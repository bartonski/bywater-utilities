#! /usr/bin/perl

use strict;
use warnings;
use C4::Context;
use YAML;

my $statement = 'select * 
from 
    reserves
    inner join items using (itemnumber)
    inner join biblio using (biblionumber)
    inner join biblioitems using (biblionumber)
    inner join borrowers using (borrowernumber)
where
    items.barcode = '31562015171368'
';
my $key_field = qw( reserves.reservenumber, items.itemnumber, biblio.biblionumber, biblioitems.biblioitemnumber, borrowers.borrowrnumber );
my $output=C4::Context->{dbh}->selectall_hashref($statement, $key_field);

print YAML::Dumper( $output );
