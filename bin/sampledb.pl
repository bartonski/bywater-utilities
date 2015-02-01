#! /usr/bin/perl

use warnings;
use strict;

use C4::Context; 

my @borrower_numbers = (); # Grab from @ARGV
my @itemnumbers = ();
my @biblionumbers = ();

sub get_numbers {
    my $dbh = shift;
    my $query = shift;
    my $id = shift;
    my @numbers = $dbh->selectrow_array( $query, {}, $id );
}

my $borrower_queries = {
    items     => { 
        query => 
            "SELECT distinct itemnumber 
             FROM items 
             INNER JOIN issues using (borrowernumber) 
             INNER JOIN old_issues using (borrowernumber) 
             INNER JOIN hold_fill_targets using (borrowernumber) 
             INNER JOIN notifys using (borrowernumber) 
             INNER JOIN old_reserves using (borrowernumber) 
             INNER JOIN reserves using (borrowernumber) 
             INNER JOIN statistics using (borrowernumber) 
             INNER JOIN tmp_holdsqueue using (borrowernumber) 
             INNER JOIN accountlines using (borrowernumber) 
             INNER JOIN linktracker using (borrowernumber) 
             WHERE borrowernumber = ?"
      , datasink => \@itemnumbers 
    }
  , biblio   => { 
        query => 
            "SELECT distinct biblionumber 
             FROM biblio
             INNER JOIN reserves using (biblionumber)
             INNER JOIN deleteditems using (biblionumber)
             INNER JOIN hold_fill_targets using (biblionumber)
             INNER JOIN old_reserves using (biblionumber)
             INNER JOIN reserveconstraints using (biblionumber)
             INNER JOIN reviews using (biblionumber)
             INNER JOIN tags_all using (biblionumber)
             INNER JOIN virtualshelfcontents using (biblionumber)
             INNER JOIN tmp_holdsqueue using (biblionumber)
             INNER JOIN ratings using (biblionumber)
             INNER JOIN linktracker using (biblionumber)
             WHERE reserves.borrowernumber = ?"  
      , datasink => \@biblionumbers 
    }
};

for my $table ( keys %$borrower_queries ) {
    for my $borrower_number  ( @borrower_numbers ) {
        push @{$borrower_queries->{$table}->{datasink}}, 
                     get_numbers( C4::Context->dbh, $borrower_queries->{$table}->{query}, $borrower_number );
    }
    print "Table: $table\n";
    print "('" . join( "','", @{$borrower_queries->{$table}->{datasink}}, ) . "')\n";
}
