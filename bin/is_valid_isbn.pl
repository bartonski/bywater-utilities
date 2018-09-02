#! /usr/bin/perl
use  Business::ISBN;
$isbn = Business::ISBN->new( $ARGV[0] ); 
print "$ARGV[0] is a valid ISBN\n" if($isbn->is_valid);
