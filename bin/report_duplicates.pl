#! /usr/bin/perl

use strict;
use warnings;
use C4::Context;
use YAML;

my @query = <>;
my $query = join( "", @query );

my %fines;
my %duplicates;

my @unpaid;
my @paid;
my %max = (
	description => 0
	, accounttype => 0 
	, amount => 0 
	, amountoutstanding => 0 
);

sub maxlen {
	return ( 
		$_[0] > $_[1]
		? $_[0] 
		: $_[1] 
	) ;
}

sub printrow {
	printf( "%" . "$max{description}s" 
	     . "|%" . "$max{accounttype}s"
	     . "|%" . "$max{amount}s" 
	     . "|%" . "$max{amountoutstanding}s\n", 
	@_);
}

print "Populating '\@query' \n";
my $output=C4::Context->dbh->selectall_arrayref($query, { Slice => {} });

print "Populating '%fines'\n";

for my $out ( @$output ) {
	my $description=$out->{description};
	my $duplicate_canditate=0;
	$description =~ s:':\\':g; # escape single quotes.
	if( $description =~ /23:59$/ ) {
		$description =~ s/ 23:59$//;
		$duplicate_canditate=1;
	} elsif ( $description =~ /11:59 PM$/ ) {
		$description =~ s/ 11:59 PM$//;
		$duplicate_canditate=1;
	}

	next unless( $duplicate_canditate );
	
	# calcuate max length of each field, for formatting purposes.
	$max{description} = maxlen( length $out->{description}, $max{description} );
	$max{accounttype} = maxlen( length $out->{accounttype}, $max{accounttype} );
	$max{amount} = maxlen(  length $out->{amount}, $max{amount} );
	$max{amountoutstanding} = maxlen( length $out->{amountoutstanding}, $max{amountoutstanding} );

	# $fines{$description} will be populated by an arrayref which each record will be pushed onto.
	if ( defined $fines{$description} ) { 
		push( @{$fines{$description}}, $out ); 
		$duplicates{$description} = 1;
		#print "DUPLICATE DESCRIPTION: $description\n";
	} else {
		$fines{$description} = [ $out ];
		#print "description: $description\n";
	}
}

print "Populating '\@paid' and '\@unpaid'\n";

for my $description ( sort keys %duplicates ) {
	ROW: for my $row ( @{$fines{$description}} ) {
		next ROW unless( defined $row->{amount} && defined $row->{amountoutstanding} );
		if ( $row->{amount} > $row->{amountoutstanding} ) {
			push( @paid, $row );
		} else {
			push( @unpaid, $row );
		}
	} 
}

print "UNPAID\n\n";
for my $row ( @unpaid ) {
	printrow( 
	     $row->{description}, 
	     $row->{accounttype}, 
	     $row->{amount}, 
	     $row->{amountoutstanding} 
	);
}

print "\nPAID\n\n";
printrow( "Description", "AT", "Amount", "Outstanding" );

for my $row ( @paid ) {
	printrow( 
	     $row->{description}, 
	     $row->{accounttype}, 
	     $row->{amount}, 
	     $row->{amountoutstanding} 
	);
}


