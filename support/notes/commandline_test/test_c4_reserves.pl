#! /usr/bin/perl

use strict;
use warnings;
use C4::Reserves;
use Getopt::Long;
use Data::Dumper qw(Dumper);
use YAML::XS qw(LoadFile);

my ($branch, $borrowernumber, $biblionumber);

my $result = GetOptions(
	'branch=s'          => \$branch
	, 'borrower=s'      => \$borrowernumber
	, 'bibnum|biblio=s' => \$biblionumber
);

my $reserve_slip = C4::Reserves::ReserveSlip($branch, $borrowernumber, $biblionumber);

print "Reserve slip for branch '$branch', borrowernumber '$borrowernumber', bilionumber '$biblionumber' is\n"
      . Dumper ( $reserve_slip )
      . "\n";

