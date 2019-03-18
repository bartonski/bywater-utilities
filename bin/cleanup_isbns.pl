#! /usr/bin/perl
use  Business::ISBN;
use Modern::Perl;
while( <> ) {
    chomp;
    my @fields = split( '\|', $_ );
    for my $field ( @fields ) {
        my $isbn = Business::ISBN->new( $field ); 
        next unless $isbn;
        say $isbn->isbn;
    }
}
