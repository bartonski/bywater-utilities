#! /usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

my %section_name = (
      tasks => 'tasks'
    , '## My high priority tickets ' => 'High Priority'
    , q(## Barton's Stale Tickets ) => 'Stale'
    , q(## My open tickets updated by someone else ) => 'Needs update'
    , q(## Other Tickets) => 'Other tickets'
);

# Key: ticket number
# Value: description
my %tasks = ();

my %sections = (
       'High Priority' => {  numberlist => [] , duplicates => [], ticket     => {}, append_description=>1 } 
     , 'Stale'         => {  numberlist => [] , duplicates => [], ticket     => {}, append_description=>1 } 
     , 'Needs update'  => {  numberlist => [] , duplicates => [], ticket     => {}, append_description=>1 } 
     , 'Other tickets' => {  numberlist => [] , duplicates => [], ticket     => {}, append_description=>0 } 
);

my @section_names=(
    'Other tickets',
    'Needs update' ,
    'Stale' ,
    'High Priority' 
);

my @final_section_names;
my $leading_newline='';

my $section_header = 'tasks';
SECTION: while( <> ) {
    chomp;
    my $current_section = $section_name{$section_header};
    my $section_test = $section_name{$_};
    if( defined $section_test ) {
        $section_header = $_;
        next SECTION;
    }

    if( $current_section eq 'tasks' ) {
        my ( $task, $time, $description ) = split ( "\t", $_ );
        next unless defined $description;
        my ( $ticketnumber ) = $description =~ /#(\d+);/ ; 
        next unless ( defined $ticketnumber );
        $tasks{ $ticketnumber } = "TODO -- $task";
    } else {
        my ( $number ) = $_ =~ /^\@rt (\d+);/;
        next unless ( defined $number );
        push @{$sections{$current_section}->{numberlist}}, $number;
        $sections{$current_section}->{ticket}->{$number} = $_;
    }
}

my %descriptions;

while ( my $current_section_name = shift @section_names ) {
    push @final_section_names, $current_section_name;
    for my $other_section_name ( @section_names ) {
        my @dup_tickets = grep { 
                defined $sections{$other_section_name}->{ticket}->{$_} 
           } @{$sections{$current_section_name}->{numberlist}};

        push( @{$sections{$current_section_name}->{duplicates}}, @dup_tickets );
        @{$sections{$current_section_name}->{numberlist}} = grep { 
                ! defined $sections{$other_section_name}->{ticket}->{$_} 
           } @{$sections{$current_section_name}->{numberlist}};
    }
}

while ( my $current_section_name = pop @final_section_names ) {
    print "$leading_newline## $current_section_name\n";
    $leading_newline="\n";
    for my $current_ticketnum (@{$sections{$current_section_name}->{numberlist}}) {
        $sections{$current_section_name}->{ticket}->{$current_ticketnum} .= " -- "
            . $tasks{$current_ticketnum}
            if( defined $tasks{$current_ticketnum} );
    }
    for my $other_section_name ( @final_section_names ) {
        if( $sections{$other_section_name}->{append_description} ) {
            for my $duplicate_ticket_number ( @{$sections{$other_section_name}->{duplicates}} ) {
                $sections{$current_section_name}->{ticket}->{$duplicate_ticket_number} .= " -- " 
                    . $other_section_name 
                    if( defined $sections{$current_section_name}->{ticket}->{$duplicate_ticket_number} );
            }
        }
    }
    for my $current_ticketnum (@{$sections{$current_section_name}->{numberlist}}) {
        if( defined $sections{$current_section_name}->{ticket}->{$current_ticketnum} ) {
            print $sections{$current_section_name}->{ticket}->{$current_ticketnum} . "\n";
        } else {
            print "Ticket not defined for '$current_section_name' '$current_ticketnum'\n";
        }
    }    
}

#print Dumper( \%sections ) . "\n";
