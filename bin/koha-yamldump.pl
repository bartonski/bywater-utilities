#! /usr/bin/perl

use strict;
use warnings;
use C4::Context;
use YAML;

my @query = <>;
my $query = join( "", @query );
my $output=C4::Context->{dbh}->$dbh->selectall_arrayref($query, { Slice => {} });

print YAML::Dumper( $output );
