#! /usr/bin/perl

# Takes a text file or reads standard input consisting of colon delimited lines
# of the format TITLE : SUBTITLE [ description 1ine1 : descripton line2 : ... ]
# Each line will be printed as a cell in a 2 column table.
#
# For example
#
# 16859   southernnh: Missing Periodical Records : research missing records
#
# "16859   southernnh" is the title, is printed very large and bold.
# "Missing Periodical Records" is the subtitle, printed large and bold.
# "research missing records" is a line of description; this is printed
# at a regular size and weight.

use warnings;
use strict;
use v5.10.0;
use File::Spec;

sub cell {
    my $fh = shift;
    my @ticket = split ': ', shift;
    my $title = shift @ticket;
    my $subtitle = shift @ticket;
    print $fh "<td>"; 
    print $fh qq|<div class="title">$title</div>|;
    print $fh qq|<div class="subtitle">$subtitle</div>|;
    print $fh join( "<br />", @ticket );
    print $fh "</td>\n"; 
}

sub body {
    my $fh = shift;
    say $fh '<body>';
    table( $fh );
    say $fh "</body>\n</html>";
}

sub table {
    my $fh = shift;
    say( $fh "<table>");
    while(<>) {
        say( $fh "<tr>");
        cell(  $fh, $_ ); # Left cell
        $_ = <>;
        cell(  $fh, $_ ) if ( defined $_ ); # Right cell
        say( $fh "</tr>");
    }
    say  $fh "</table>";
}

sub head {
    my $fh = shift;
    say $fh '<html>
<head>
<title>Weekly tickets</title>
<style>
table {
    border-collapse:collapse;
}
table,th, td {
    text-align:center;
    font-size: 18px;
    border: 1px solid black;
}
th, td {
    width: 375px;
    height:125px;
}
div.title {
    font-size: 36px;    
    font-weight: 900;
}
div.subtitle {
    font-size: 22px;    
    font-weight: 900;
}
</style>
</head>
';
}

sub main {
    # TODO: should be able to specify output file name on command line.
    my $home=$ENV{HOME};
    my $basename='weekly_list';
    my $output_path=File::Spec->join(
                        $home,
                        'public_html',
                    );
    my $output_file=File::Spec->join($output_path, "${basename}.html");
    my $OUT_FH;
    open( $OUT_FH, '>', $output_file) or die "Cannot open '$output_file' for output: $!";
    head( $OUT_FH );
    body( $OUT_FH );
    close $OUT_FH;
}

main()
