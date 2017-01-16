#! /usr/bin/perl 

# Used for ordering RT tickets with relative dates.

use Modern::Perl;

my %minutes_factor = (
    minutes => 1,
    hours => 60,
    days => 1440,
    weeks => 10080,
);

while( <> ) {
    chomp;
    my ( $id, $Subject, $QueueName, $ExtendedStatus, $LastUpdatedRelative, $LastUpdatedBy ) = split( "\t" );
    if( my( $scalar, $factor ) = $LastUpdatedRelative =~ /(\d+)\s+(minutes|hours|days|weeks)/ ) {
        $LastUpdatedRelative = sprintf( "%010d minutes ago", $scalar *  $minutes_factor{$factor} );
        say join( "\t", $id, $Subject, $QueueName, $ExtendedStatus, $LastUpdatedRelative, $LastUpdatedBy );
    } else {
        say $_;
    }
}
