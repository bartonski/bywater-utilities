#! /usr/bin/perl

use Modern::Perl;

my @tickets;

while (<>) {
    chomp;
    my @words = split(' '); 
    for my $word (@words) {
        push @tickets, $word if( $word =~ /^\d+$/)
    }
}

say "https://mail.google.com/mail/u/1/#search/(from%3Asupport%40bywatersolutions.com)+is%3Aunread+subject%3A(" . join( "+OR+", @tickets ) .  ")";
