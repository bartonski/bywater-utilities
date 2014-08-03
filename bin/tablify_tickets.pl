#! /usr/bin/perl

use warnings;
use strict;

print '<p><style>
table
{
border-collapse:collapse;
}
table,th, td
{
border: 1px solid black;
}
</style></p>
';

# <a href="http://ticket.bywatersolutions.com/Ticket/Display.html?id=17530">17530</a>
sub table_row {
    my ( $ticket_num, $description ) = @_;
    my ( $partner ) = $description =~ /^(\w+):/;
    my $style = $partner ? '' : 'style="color:#FF0000"';
    print("<tr>\n");
    print("<td><a $style href=\"http://ticket.bywatersolutions.com/Ticket/Display.html?id=$ticket_num\">$ticket_num</a></td> ");
    print("<td>$description</td>\n");
    print("</tr>");
}

print("<table>");
while( <> ) {
    my ( $ticket_num, $description, $garbage );
    table_row( $ticket_num, $description ) if ( ( $ticket_num, $description, $garbage ) = /(\d+)\s+(.*)(\s+\d+\s+Support.*)/);
}
print("</table>");

