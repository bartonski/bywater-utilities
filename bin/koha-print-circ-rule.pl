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
sub print_header {
    my $string = "@_";
    my $underline = '=' x length( $string );
    print "\n";
    print "${string}\n";
    print "${underline}\n";
}

my $opt_borrower_card_num;
my $opt_item_barcode;
GetOptions(
      "cardnum=s"   => \$opt_borrower_card_num
    , "barcode=s"   => \$opt_item_barcode
);

my $item = GetItem(GetItemnumberFromBarcode( $opt_item_barcode ));
my ($borrower) = &GetMemberDetails( '', $opt_borrower_card_num); # not sure why this was returned in list context, but it's that way in the perldoc.
my $branch = C4::Circulation::_GetCircControlBranch($item,$borrower);
my $borrowertype = $borrower->{categorycode};
my $biblioitem = GetBiblioItemData($item->{biblioitemnumber});
my $itemtype = ( C4::Context->preference('item-level_itypes') ) ? $item->{'itype'} : $biblioitem->{'itemtype'};
my $loanlength = C4::Circulation::GetLoanLength($borrowertype,$itemtype,$branch);
my ($hardduedate,$hardduedatecompare) = C4::Circulation::GetHardDueDate($borrowertype,$itemtype,$branch);
my $irule = C4::Circulation::GetIssuingRule($borrowertype,$itemtype,$branch);

my @fields = (
      [ 'Borrower'                 => $borrower           ]
    , [ 'Item'                     => $item               ]
    , [ 'Circulation Branch'       => $branch             ]
    , [ 'Item type'                => $itemtype           ]
    , [ 'Loan Length'              => $loanlength         ]
    , [ 'Hard Due Date'            => $hardduedate        ]
    , [ 'Hard Due Date Comparison' => $hardduedatecompare ]
    , [ 'Issuing Rule'             => $irule              ]
);

for my $field ( @fields ) {
    my ( $header, $value ) = @$field;
    print_header( $header );
    print Dumper( $value );
}
