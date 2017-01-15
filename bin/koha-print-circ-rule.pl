#! /usr/bin/perl

use strict;
use warnings;

use C4::Circulation;
use C4::Items;
use C4::Members;
use C4::Biblio;
use Getopt::Long;
use Data::Dumper;
use C4::Context;
use List::Util qw( any pairgrep );

sub header {
    my $string = "@_";
    my $underline = '=' x length( $string );
    return   "\n"
           . "${string}\n"
           . "${underline}\n";
}


my $fields_to_pull = {
      borrower         => [ qw( categorycode borrowernumber branchcode description dateenrolled dateexpiry firstname surname dateofbirth debarred userid cardnumber ) ]
    , item             => [ qw( withdrawn restricted notforloan itemnumber ccode itemcallnumber barcode itemlost datelastseen homebranch holdingbranch timestamp damaged itype onloan ) ]
    , issueing_rules   => [ qw( itemtype categorycode branchcode issuelength lengthunit renewalperiod ) ]
    , branch_item_rule => [ qw( returnbranch holdallowed  ) ]
};

my $opt_borrower_card_num;
my $opt_item_barcode;

GetOptions(
      "cardnum=s"   => \$opt_borrower_card_num
    , "barcode=s"   => \$opt_item_barcode
);

my $item           = GetItem( GetItemnumberFromBarcode( $opt_item_barcode ) );
my ( $borrower )   = &GetMemberDetails( '', $opt_borrower_card_num ); # not sure why this was returned in list context, but it's that way in the perldoc.
my $borrowerinfo   = C4::Members::GetMember( borrowernumber => $borrower->{borrowernumber} );
my $branch         = C4::Circulation::_GetCircControlBranch( $item, $borrower );
my $borrowertype   = $borrower->{categorycode};
my $biblioitem     = GetBiblioItemData( $item->{biblioitemnumber} );
my $itemtype       = ( C4::Context->preference( 'item-level_itypes' ) ) ? $item->{'itype'} : $biblioitem->{'itemtype'};
my $loanlength     = C4::Circulation::GetLoanLength( $borrowertype, $itemtype, $branch );
my ( $hardduedate, $hardduedatecompare ) = C4::Circulation::GetHardDueDate( $borrowertype, $itemtype, $branch );
my $branchitemrule = C4::Circulation::GetBranchItemRule( $branch, $item->{'itype'} );
my $irule          = C4::Circulation::GetIssuingRule( $borrowertype, $itemtype, $branch );

( %$borrower ) = pairgrep { any { $_ eq $a } @{$fields_to_pull->{borrower}}  } ( %$borrower );
( %$item )     = pairgrep { any { $_ eq $a } @{$fields_to_pull->{item}}  } ( %$item );

my @fields = (
      [ 'Borrower'                 => $borrower           ]
    , [ 'Item'                     => $item               ]
    , [ 'Circulation Branch'       => $branch             ]
    , [ 'Item type'                => $itemtype           ]
    , [ 'Loan Length'              => $loanlength         ]
    , [ 'Hard Due Date'            => $hardduedate        ]
    , [ 'Hard Due Date Comparison' => $hardduedatecompare ]
    , [ 'Issuing Rule'             => $irule              ]
    , [ 'Branch Item Rule'         => $branchitemrule     ]
);

for my $field ( @fields ) {
    my ( $header, $value ) = @$field;
    print header( $header );
    print Dumper( $value );
}
