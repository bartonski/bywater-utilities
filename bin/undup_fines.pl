#! /usr/bin/perl

use warnings;
use strict;
use C4::Context;
use Getopt::Long;
use Pod::Usage;
use Text::CSV_XS;

my $global_dbh = C4::Context->dbh();

my $opt_do_eet=0;
my $opt_drop=1;
my $opt_new_table=1;
my $opt_report_file='~/undup_fines_report.csv';
my $opt_help=0;

GetOptions (
      'c|commit'        => \$opt_do_eet
    , 'd|drop=s'        => \$opt_drop
    , 'n|new_table=s'   => \$opt_new_table
    , 'r|report_file=s' => \$opt_report_file
    , 'h|help'          => \$opt_help
);

pod2usage(1) and exit if $opt_help;

my $global_csv = Text::CSV_XS->new ({ binary => 1, eol => "\n" })
    or die "Cannot use CSV: " . Text::CSV->error_diag ();

my $global_report_fh;
open $global_report_fh, '>:encoding(utf8)', $opt_report_file
    or die "Cannot open report file '$opt_report_file' for output: $!";

# possible values 24hr, ( 12hr ? ) 
my $time_format = C4::Context->preference('TimeFormat');
my $time_due_correct = ( $time_format eq '24hr' ) ? "23:59"    : "11:59 PM" ;
my $time_due_fixme   = ( $time_format eq '24hr' ) ? "11:59 PM" : "23:59"    ;


my $temp_table_name   = 'temp_duplicate_fines';
my $temp_table_drop   = "DROP TABLE IF EXISTS $temp_table_name;";

print "Creating temp table '$temp_table_name'";

# Note that my_description must be varchar() in order to be part of the
# index, and reuires a maximum length.  used  the following query to find
#
# select LENGTH(description) from accountlines order by LENGTH(description) DESC limit 1;
# +---------------------+
# | LENGTH(description) |
# +---------------------+
# |                 276 |
# +---------------------+
# 1 row in set (0.99 sec)
#
# There is a possible race condition if a longer description is added between
# the time of the table creation and the time that we populate all of the
# values in the temp table, but I think that the risk is negligable as long
# as the script is run at a time when fines are not actively being calculated,
# e.g. heavy circ times or during the run of fines.pl.

if( $opt_new_table ) {
    $global_dbh->do( $temp_table_drop );

    my $description_sth = $global_dbh->prepare(
        "select LENGTH(description) from accountlines order by LENGTH(description) DESC limit 1;"
    );
    $description_sth->execute();
    my $description = $description_sth->fetchrow_hashref();

    $global_dbh->do( 
"CREATE TABLE $temp_table_name (
    id                    int         NOT NULL         AUTO_INCREMENT PRIMARY KEY,
    accountlines_id       int(11)     NOT NULL, 
    borrowernumber        int(11)     NOT NULL,
    accountno             smallint(6) NOT NULL,
    itemnumber            int(11),
    description           mediumtext,
    my_description        varchar($description->{length}) NOT NULL,
    timestamp             timestamp,
    date                  date,
    amount                decimal(28,6),
    amount_paid           decimal(28,6),
    correct_timeformat    int,
    accounttype           varchar(5),
    lastincrement         decimal(28,6),
    KEY accountlines_id   (accountlines_id),
    KEY fine_id           ( my_description, borrowernumber,  itemnumber )
) ENGINE=InnoDB CHARSET=utf8;"
    );
}

my $fines_sth = $global_dbh->prepare(
"SELECT *
FROM accountlines
WHERE accounttype in ('F', 'FU', 'O', 'M')
  AND ( description like '%$time_due_correct' OR description like '%$time_due_fixme');"
);

my $insert_temp_sth = $global_dbh->prepare( 
"INSERT INTO $temp_table_name ( 
    accountlines_id, 
    description, 
    my_description,
    timestamp, 
    date,
    amount,
    amount_paid,
    correct_timeformat,
    borrowernumber,
    accountno,
    itemnumber,
    accounttype,
    lastincrement
) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? );"
);

# There should only be two rows for each description -- timeformat will be 0 or 1.
my $count_fines_sth = $global_dbh->prepare(
"SELECT 
    count(*) as count
FROM $temp_table_name
WHERE my_description = ?"
);

my $bad_fine_sth = $global_dbh->prepare(
"SELECT * 
FROM $temp_table_name
WHERE correct_timeformat = 0"
);

my $good_fine_sth = $global_dbh->prepare(
"SELECT * 
FROM $temp_table_name
WHERE correct_timeformat != 0
AND my_description = ?"
);

my $data_to_keep_sth = $global_dbh->prepare(
"select 
    a.my_description, 
    CASE 
        WHEN a.correct_timeformat=1 THEN a.description 
        ELSE b.description 
    END as description, 
    a.correct_timeformat as first_is_good, 
    a.accounttype as first_accounttype,
    a.amount_paid as first_amount_paid,
    b.accountlines_id as accountlines_id, 
    b.date as date,
    b.accounttype as second_accounttype,
    b.lastincrement as lastincrement,
    b.amount as amount,
    b.amount_paid as second_amount_paid
from 
    temp_duplicate_fines a
    inner join temp_duplicate_fines b using (borrowernumber, itemnumber, my_description) 
where a.date < b.date"
);

my $select_accountline_sth = $global_dbh->prepare(
"SELECT *
FROM accountlines
WHERE accountlines_id = ?"
);

my $delete_accountline_sth = $global_dbh->prepare(
"DELETE FROM accountlines
WHERE accountlines_id = ?"
);

# Replace bad time_due with correct time_due, 
# but only at the end of the description.
my $fix_accountline_description_sth = $global_dbh->prepare(
"UPDATE accountlines
SET description = CONCAT(
        substring( description, 1, char_length(description) 
                   - char_length('$time_due_fixme') 
                 ),
        '$time_due_correct' 
    )
WHERE accountlines_id = ?"
);

my $update_amount_outstanding_sth = $global_dbh->prepare(
"UPDATE accountlines
SET amount_outstanding=?
WHERE accountlines_id=?");

sub log_warn {
    my $logdata = [ "Warning", @_ ];
    $global_csv->print ( $global_report_fh, $logdata );
}

sub log_and_commit {
    my (
          $commit_sth 
        , $accountlines_sth 
        , $statement_arguments # arrayref, with accountlines_id as the last element.
        , $message 
    ) = @_;

    my @arguments = ( @$statement_arguments );
    my $accountlines_id = $arguments[ -1 ];
    # Log to csv file.
    $accountlines_sth->execute( $accountlines_id );
    while( my $accountline = $accountlines_sth->fetchrow_hashref ) {
        my $columns = [
              $message
            , ( %$accountline )
        ];
        $global_csv->print ( $global_report_fh );
    } 

    # Run query if $opt_do_eet is true.
    if( $opt_do_eet ) {
        $commit_sth->execute( @arguments );
    }
}

sub log_and_insert {
    my (
          $insert_sth 
        , $statement_arguments # arrayref, with accountlines_id as the last element.
        , $message 
    ) = @_;

    my @arguments = ( @$statement_arguments );
    # Log to csv file.
    # $accountlines_sth->execute( $arguments[ -1 ] );
    # while( my $accountline = $accountlines_sth->fetchrow_hashref ) {
        # my $columns = [
              # $message
            # , ( %$accountline )
        # ];
        # $global_csv->print ( $global_report_fh );
    # } 

    # Run query if $opt_do_eet is true.
    if( $opt_do_eet ) {
        $insert_sth->execute( @arguments );
    }
}


sub update_amount_outstanding {
    my (
          $record
        , $amount
    ) = @_;

    my $accountlines_id = $record->{accountlines_id};
    my $amount_outstanding = $amount < 0 ? 0        : $amount;
    my $credit             = $amount < 0 ? -$amount : undef;

    log_and_commit ( $update_amount_outstanding_sth ,
                     $select_accountline_sth, 
                     [ $amount_outstanding, $record->{accountlines_id} ],  
                     "Adjusting amount_outstanding for "
                     . "'$record->{accountlines_id}' to "
                     . "'$amount_outstanding'"
                   );
    
    if( $credit ) {
        # TODO: write warning about credit being owed.
    }
}

############################ Create temp table ###############################

print "Creating temp table '$temp_table_name'\n";

my $i=0;
$fines_sth->execute();
FINE: while( my $fine = $fines_sth->fetchrow_hashref() ) {
    $i++;
    my $newline = ( $i % 100 ) ? "" : "\r$i";
    print ".$newline";

    if    (    not defined($fine->{borrowernumber}) 
            || not defined($fine->{my_description})
            || not defined($fine->{itemnumber})
          ) {
       log_warn(   "Accountlines record is missing borrowernumber, description or itemnumber"
                 , $fine->{accountlines_id}
                 , $fine->{borrowernumber}
                 , $fine->{accountno}
                 , $fine->{itemnumber}
                 , $fine->{date}
                 , $fine->{amount}
                 , $fine->{description}
                 , $fine->{dispute}
                 , $fine->{accounttype}
                 , $fine->{amountoutstanding}
                 , $fine->{lastincrement}
                 , $fine->{timestamp}
                 , $fine->{notify_id}
                 , $fine->{notify_level}
                 , $fine->{note}
                 , $fine->{manager_id}
               ); 
        next FINE;
    }

    my $my_description = $fine->{description};
    my $amount_paid    = $fine->{amount} - $fine->{amountoutstanding};
    my $correct_timeformat 
         = $fine->{description} =~ /${time_due_correct}$/ ? 1 : 0;
    $my_description =~ s/(${time_due_correct}|${time_due_fixme})$//;
    $insert_temp_sth->execute(
        $fine->{accountlines_id}, # accountlines_id 
        $fine->{description},     # original_description 
        $my_description,          # my_description
        $fine->{timestamp},       # timestamp 
        $fine->{date},            # date
        $fine->{amount},          # amount
        $amount_paid,             # amount_paid
        $correct_timeformat,      # correct_timeformat
        $fine->{borrowernumber},
        $fine->{accountno},
        $fine->{itemnumber},
        $fine->{accounttype},
        $fine->{lastincrement}
    );
}

print "\n";

#    a.my_description, 
#    CASE 
#        WHEN a.correct_timeformat=1 THEN a.description 
#        ELSE b.description 
#    END as description, 
#    a.correct_timeformat as first_is_good, 
#    a.accounttype as first_accounttype,
#    a.amount as first_amount,
#    a.amount_paid as first_amount_paid,
#    b.accountlines_id as accountlines_id, 
#    b.date as date,
#    b.accounttype as second_accounttype,
#    b.lastincrement as lastincrement,
#    b.amount as second_amount,
#    b.amount_paid as second_amount_paid

print "Creating list of data to keep\n";

$data_to_keep_sth->execute();
my %data_to_keep;
KEEPDATA: while( my $keep = $data_to_keep_sth->fetchrow_hashref() ) {
    my $total_paid = $keep->{first_amount_paid} + $keep->{second_amount_paid};
    my $amount = $keep->{amount} || 0;
    my $amountoutstanding = $amount - $total_paid;
    if ( $amountoutstanding < 0 ) {
        # TODO log debit needed.
        log_warn( "Amount paid is greater than amount outstanding", 
                  "Accountlines ID:" , $keep->{accountlines_id} ,
                  "Total paid:"      , $total_paid              ,
                  "Fine amount:"     , $keep->{amount}          ,
                  "Credit:"          , -$amountoutstanding
                );
        $amountoutstanding = 0;
    };

    $data_to_keep{ $keep->{my_description} } = {
        accountlines_id => $keep->{accountlines_id}
        , accounttype => $keep->{first_accounttype} eq 'FU' ? $keep->{second_accounttype} : $keep->{first_accounttype}
        , date => $keep->{date}
        , lastincrement => $keep->{lastincrement}
        , amount => $keep->{amount}
        , amountoutstanding => $amountoutstanding
    };
}

## TESTING: Stop after temp table has been populated.

exit 0;

# There should only be two rows for each description 
# -- timeformat will be 0 or 1.
# bad_fine_sth queries for fines where correct_timeformat is 0
$bad_fine_sth->execute();
BADFINES: while( my $bad_fine = $bad_fine_sth->fetchrow_hashref() ) {
    $count_fines_sth->execute($bad_fine->{my_description});
    my $count;
    while( my $sanity_check = $count_fines_sth->fetchrow_hashref() ) {
        $count=$sanity_check->{count};
        if( $count > 2 ) {
            print   "WARNING: $sanity_check->{count} occurrences of "
                  . "'$bad_fine->{my_description}'. Skipping records.\n";
            next BADFINES;
        }
    }

    if( $count == 2 ) {
        # From notes in ticket:
        #
        # Fines *START* with accounttype 'FU' and are converted to 'F' when an item is checked in.
        #
        # Furthermore, it seems like we can always use the later
        # of the the two fines for accounttype, date, lastincrement,
        # and amount. Amount paid will have to be adjusted based on the
        # earlier fine. Description will match the correct timeformat.
        #
        # I think that this is correct in everything except accounttype ...
        # if accounttype is anything other than "FU" we will keep the
        # "Higher" accounttype.

        # Write a function to pull the following:
        # $data_to_keep = {
        #     accountlines_id => # the later of the two accountlines entries
        #     accounttype     => # "FU", unless one of the records has a different entry.
        #     date            => # The later of the two dates
        #     lastincrement   => # Lastincrement for the later record
        #     amount          => # Adjust amount using amount_paid from earlier record
        #     description     => # 'GOOD' description
        # } 

        # After we've found $data_to_keep, we can simply do an update on the newer record, and delete the old.

#        log_and_commit( $delete_accountline_sth, 
#                        $select_accountline_sth, 
#                        [ $bad_fine->{accountlines_id} ],  
#                        $bad_fine,
#                        "Deleting duplicate fine '$bad_fine->{accountlines_id}'"
#                      );
    } else {
        # Only the bad fine exists. Fix the description and move on.
        log_and_commit( $fix_accountline_description_sth,
                        $select_accountline_sth, 
                        [ $bad_fine->{accountlines_id} ],  
                        $bad_fine,
                        "fixing description. "
                        . "old: $time_due_fixme "
                        . "new: $time_due_correct '$bad_fine->{accountlines_id}'"
                      );

        rename_accountline( $bad_fine->{accountlines_id} );
        next BADFINES;
    }

    next BADFINES if ( $bad_fine->{amount_paid} == 0 );

    $good_fine_sth->execute( $bad_fine->{my_description} );
    my @good_accountlines_id = ();
    my $good_fine;
    GOODFINES: while ( $good_fine = $good_fine_sth->fetchrow_hashref() ) {
        push @good_accountlines_id, $good_fine->{accountlines_id};
    }
    
    if( scalar @good_accountlines_id > 1 ) {
        # This *shouldn't* happen.
        print   "WARNING: '$good_fine->{my_description}' "
              . "occurs more than once "
              . "-- see the rows having the following  accountlines_ids: "
              . join (', ', @good_accountlines_id)
              . "\n" ;
        next BADFINES; # We don't know which "good" fine we want to adjust, so skip.
    }
    
    my $new_amount_outstanding = $good_fine->{amount_outstanding} - $bad_fine->{amount_paid};

    # update_amount_outstanding() will also create credit
    # if $new_amount_outstanding is less than 0. 
    update_amount_outstanding( $good_fine, $new_amount_outstanding );
}

END {
    unless( $opt_help ) {
        $global_dbh->do( $temp_table_drop ) if( $opt_drop );
        close $global_report_fh;
    }
}

=head1 NAME

undup_fines.pl

=head1 SYNOPSIS

./undup_fines.pl [-c] [-d[=0]] [-n[=0]] [-r[=REPORT FILE NAME]] 
./undup_fines.pl [-h]

=head1 DESCRIPTION

=head2 The problem being fixed

The duplicates were caused by a bug in C4::Overdues::UpdateFine()
where fines to be updated were looked up by description. 

The descriptions for fines include the due date/time of the item.
All items are due at one minute before midnight.  UpdateFine() did
not take into account changes in time format, as specified using the
'TimeFormat' system preference. The 'TimeFormat' system preference may
be set to '24H' or '12H'. Time due would be set to '23:59' or '11:59 PM'
respectively. Changing TimeFormat did not re-set the time formats within
the descriptions, so UpdateFine created duplicate fines for all fines
updated where a fine description had the old time format.

This function would update fines with the following account types:

   F   | Fine
   FU  | Fine Update
   O   | Overdue
   M   | Miscelaneous

For our purposes, fines with a time format which does not match
the current TimeFormat will be considered 'BAD' and fines which
match will be considered 'GOOD'.

For our purposes, we will have to consider the following variables:

    * Are there duplicate fines?
    * Is the fine GOOD or BAD?
    * Has the fine been paid?

If there are no duplciate fines:
    Leave GOOD fines alone
    Change the date format on BAD fine to make it GOOD.

If there are duplicate fines:
    For each BAD fine:
        Delete the BAD fine.
        If the fine has been paid: 
           reduce the amount_outstanding on the corresponding GOOD fine.
        If the amount_outstanding on the GOOD fine is negative, set it to 0, and create a debit.

Fines are considered duplicates if the following conditions are true:

    * The descriptions differ by only the time format at the end.
    * borrowernumber matches
    * itemnumber matches

In the case of serials, it is possible that description and borrowernumber
will match, but itemnumber is NULL. In these cases, the records will be
sent to the report file, but no changes will be made automatically. These
will require manual modification by staff.

=head2 The procedure of fixing the problem.

Read the 'TimeFormat' system preference

Create a temporary fines table 'temp_duplicate_fines' containing 
any fines where the account types are in "F", "FU", "O", "M".

The temporary table will have the following information:

    accountlines_id        | Link back to accountlines
    original_description   | Including the offending time
    my_description         | Without the time part.
    timestamp              | Timestamp from accountlines
    date                   | Date from accountlines
    amount_paid            | amount - amountoutstanding
    correct_timeformat     | 0 for 'BAD', 1 for 'GOOD'.

There should only be two rows for each description -- timeformat will be 0 or 1.

For each entry with correct_timeformat = 0
   if amount_paid = 0 
      delete entry from accountlines
   elsif amount_paid < other amout outstanding
      delete entry from accountlines
      decrease otther amount outstanding
   else
      delete entry from accountlines
      set other amount outstanding to 0
      credit account by the difference

=head1 OPTIONS

=over 8

=item B<-c|--commit>

undup_fines.pl will not make any changes to the fines table unless the
'-c' flag is specified.

=item B<-d|--drop>

Drop temp table after program has completed. This is the default option,
use '-d=0' if you do not wish to drop the table.

=item B<-n|--new_table>

Create temp table when the program starts. This this is the default
option, use '-n=0' if you do not wish to create the table for faster
startup. The table B<must> exist for the program to run. This can be
accomplished by running the program with the the '-d=0' option.

=item B<-r|--report_file>

The program will create a CSV file containing a list of the actions
taken. The file name defaults to '~/undup_fines_report.csv' if not
specified.

=item B<-h|--help>

Print this help message and exit.

=back

=head1 AUTHOR

Barton Chittenden <barton@bywatersolutions.com>

=head1 LICENSE

This file has the same license as Koha.

Koha is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free
Software Foundation; either version 2 of the License, or (at your option)
any later version.

You should have received a copy of the GNU General Public License
along with Koha; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

=head1 DISCLAIMER OF WARRANTY

Koha is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
for more details.

=cut