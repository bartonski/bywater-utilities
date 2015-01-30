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
my $opt_report_file="$ENV{HOME}/undup_fines_report.csv";
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
log_info( "Syspref 'Timeformat'", $time_format );

my $time_due_correct = ( $time_format eq '24hr' ) ? "23:59"    : "11:59 PM" ;
log_info( "internal: '\$time_due_correct'", $time_due_correct );

my $time_due_fixme   = ( $time_format eq '24hr' ) ? "11:59 PM" : "23:59"    ;
log_info( "internal: '\$time_due_fixme'", $time_due_fixme );

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
        "select LENGTH(description) as 'length' from accountlines order by LENGTH(description) DESC limit 1;"
    );
    $description_sth->execute();
    my $description = $description_sth->fetchrow_hashref();
    my $temp_create_statement =
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
) ENGINE=InnoDB CHARSET=utf8;"; 

    $global_dbh->do( $temp_create_statement );
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

my $temp_fines_having_count_query =
"select 
    borrowernumber, 
    itemnumber, 
    my_description 
from temp_duplicate_fines 
group by borrowernumber, itemnumber, my_description having 
count(*) = ?";

my $temp_fines_having_coung_sth = $global_dbh->prepare( $temp_fines_having_count_query );

## TODO: need to test for duplicate fines that have the same date. This program won't be able to handle those.

my $data_to_keep_query = 
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
    b.amount_paid as second_amount_paid,
    borrowernumber,
    itemnumber
from 
    temp_duplicate_fines a
    inner join temp_duplicate_fines b using (borrowernumber, itemnumber, my_description) 
where 
    a.date < b.date
    and a.borrowernumber = ? 
    and a.itemnumber = ?  
    and  a.my_description = ?
";
my $data_to_keep_sth = $global_dbh->prepare( $data_to_keep_query );

my $update_accountlines_query = 
"update accountlines
set
    description       = ?,
    date              = ?,
    accounttype       = ?,
    lastincrement     = ?,
    amount            = ?,
    amountoutstanding = ?,
    note              = ?
where accountlines_id = ?";

my $update_accountlines_sth = $global_dbh->prepare( $update_accountlines_query );

my $delete_accountlines_query = 
"DELETE FROM accountlines
WHERE accountlines_id = ?";

my $delete_accountlines_sth = $global_dbh->prepare( $delete_accountlines_query );

sub log_warn {
    my $logdata = [ "Warning", @_ ];
    $global_csv->print ( $global_report_fh, $logdata );
}

sub log_info {
    my $logdata = [ "Info", @_ ];
    $global_csv->print ( $global_report_fh, $logdata );
}

############################ Create temp table ###############################

print "Creating temp table '$temp_table_name'\n";

my %undefined_good_description;
my %bad_description;
my $i=0;
$fines_sth->execute();
FINE: while( my $fine = $fines_sth->fetchrow_hashref() ) {
    $i++;
    my $newline = ( $i % 100 ) ? "" : "\r$i";
    print ".$newline";

    # used for logging
    my @current_fine_record = (
           $fine->{accountlines_id}
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

    my $my_description = $fine->{description};
    my $amount_paid    = $fine->{amount} - $fine->{amountoutstanding};
    my $correct_timeformat 
         = $fine->{description} =~ /${time_due_correct}$/ ? 1 : 0;
    $my_description =~ s/(${time_due_correct}|${time_due_fixme})$//;

    my %undefined_field = ();
    for my $f ( qw ( borrowernumber description itemnumber ) ) {
        $undefined_field{$f} = 1 if not defined($fine->{$f});
    }

    unless ( $correct_timeformat ) {
        $bad_description{$my_description} = 1;
        log_warn(   "Accountlines description '" 
                    . $my_description 
                    . "' matches record with undefined fields. Please inspect."
                  , @current_fine_record );
        
    }
    
    my @undefined_fields = ( keys %undefined_field );
    if ( scalar @undefined_fields > 0 ) {
        #  We don't want to clog the logs with warnings about fines what have the correct
        #  time format. We only care if there's a possibility that they're a duplicate.
        #  We'll only log if it matches the currently known bad timeformats, and
        #  we'll also put it into a list of undefined good time formats. If either of
        #  these match, we'll log it.
        my $log_correct_timeformat = 0;
        if( $correct_timeformat ) {
            $log_correct_timeformat = 1 if $bad_description{$my_description};
            $undefined_good_description{$my_description} = 1;
        }
        if( $correct_timeformat == 0 || $log_correct_timeformat == 1 ) {
            log_warn(   "Accountlines record is missing " 
                        . join ( ', ' , @undefined_fields ) 
                        . ". Please inspect."
                        , @current_fine_record
                   ); 
            $bad_description{$my_description} = 1;
        }
        next FINE;
    }

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

print "\nCreating list of data to keep\n";

my %data_to_keep;

$temp_fines_having_coung_sth->execute(2);
DUPLICATES: while ( my $duplicate = $temp_fines_having_coung_sth->fetchrow_hashref() ) {
    my @key = ( $duplicate->{borrowernumber}, $duplicate->{itemnumber} , $duplicate->{my_description} ); 
    my $key = join( '', @key );
    $data_to_keep_sth->execute( @key );
    log_info( $data_to_keep_query, @key );;
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

        $data_to_keep{ $key } = {
            accountlines_id => $keep->{accountlines_id}
            , description => $keep->{description}
            , accounttype => $keep->{first_accounttype} eq 'FU' 
                                                           ? $keep->{second_accounttype} 
                                                           : $keep->{first_accounttype}
            , date => $keep->{date}
            , lastincrement => $keep->{lastincrement}
            , amount => $keep->{amount}
            , amountoutstanding => $amountoutstanding
        };
    }
}

$temp_fines_having_coung_sth->execute(1);
SINGLETONS: while ( my $singleton = $temp_fines_having_coung_sth->fetchrow_hashref() ) {
    my @key = ( $singleton->{borrowernumber}, $singleton->{itemnumber} , $singleton->{my_description} ); 
    my $key = join( '', @key );

    # Update description if correct_timeformat is 0.
}

# Check for fines having count greater than 3... This shouldn't happen, but stranger things have happened.

## TESTING: Stop after temp table has been populated.

# "update accountlines
# set
#     description       = ?,
#     date              = ?,
#     accounttype       = ?,
#     lastincrement     = ?,
#     amountoutstanding = ?,
#     note              = ?
# where accountlines_id = ?"


UPDATE_FINES: for my $key ( keys %data_to_keep ) {
    my $accountlines_id = $data_to_keep{$key}->{accountlines_id};
    my @update_accountlines_args = (
            $data_to_keep{$key}->{description},
            $data_to_keep{$key}->{date},
            $data_to_keep{$key}->{accounttype},
            $data_to_keep{$key}->{lastincrement},
            $data_to_keep{$key}->{amount},
            $data_to_keep{$key}->{amountoutstanding},
            "Updated by fines de-duplicator",
            $accountlines_id
        );

    log_info( $update_accountlines_query, @update_accountlines_args );
    if( $opt_do_eet ) {
        $update_accountlines_sth->execute( @update_accountlines_args );
    }
}

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

    } else {
        # Only the bad fine exists. Fix the description and move on.

        next BADFINES;
    }

    next BADFINES if ( $bad_fine->{amount_paid} == 0 );

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
