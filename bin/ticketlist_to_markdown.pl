#! /usr/bin/perl

use Modern::Perl;

my $header_regex = qr/
    (^.*Stale Tickets) |
    (^My Open Tickets Partner Updates) |
    (^My tickets last updated by me two days ago ) |
    (^Other tickets)
/nx;

while( <> ) {
    chomp;
    if( my ($ticket) = /^ticket (\d+)/ ) {
        my $ticketlink = `ticketprint $ticket  "{%id%} | [ {%subject%} ](https://ticket.bywatersolutions.com/Ticket/Display.html?id={%id%})"`;
        chomp $ticketlink;
        say '|' . $ticketlink . '|';
    } elsif ( /^\s*$/) {
        next;
    } else {
        say "";
        say "## " . $_;
        say "";
        say "|Ticket #     | subject |";
        say "|-------------|---------|";
    }
}
