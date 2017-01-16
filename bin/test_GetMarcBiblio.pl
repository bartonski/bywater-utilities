#! /usr/bin/perl

# Usage: test_GetMarcBiblio.pl biblionumber
#        ... meant for debugging.

use C4::Context;
use Modern::Perl;
use C4::Biblio;
use Data::Dumper;

my $biblionumber = $ARGV[0];

my $marc = GetMarcBiblio( $biblionumber );

print dumper( $marc );
