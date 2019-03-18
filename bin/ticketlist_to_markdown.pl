#! /usr/bin/perl

use Modern::Perl;

my $header_regex = qr/
    (^.*Stale\ Tickets) |
    (^My\ Open\ Tickets\ Partner\ Updates) |
    (^My\ tickets\ last\ updated\ by\ me\ two\ days\ ago) |
    (^My\ Closed\ Tickets\ Updated\ By\ Partners\ Past\ 72\ hrs) |
    (^My\ overdue\ reminders) |
    (^My\ reminders.*) |
    (^Other\ tickets)
/nx;


while( <> ) {
    chomp;
    if( my ($ticket) = /^ticket (\d+)/ ) {
        my $ticketlink = `ticketprint $ticket  "{%id%} | [ {%subject%} ](https://ticket.bywatersolutions.com/Ticket/Display.html?id={%id%})"`;
        chomp $ticketlink;
        say '|' . $ticketlink . '|';
    } elsif ( $_ =~ /^$|^----/ ) {
        next;
    } else {
        say "";
        say "## " . $_;
        say "";
        say "|             |         |";
        say "|-------------|---------|";
    }
}
