#! /usr/bin/perl

use warnings;
use strict;
use POSIX;

use C4::Members;
use Koha::DateUtils;
use Data::Dumper;

my $issues = C4::Members::GetPendingIssues( @ARGV );

print Dumper( $issues );



sub islip {
    my ($branch, $borrowernumber, $quickslip) = @_;

#   return unless ( C4::Context->boolean_preference('printcirculationslips') );

    my $now       = POSIX::strftime("%Y-%m-%d", localtime);

    my $issueslist = GetPendingIssues($borrowernumber);
    foreach my $it (@$issueslist){
        if ((substr $it->{'issuedate'}, 0, 10) eq $now || (substr $it->{'lastreneweddate'}, 0, 10) eq $now) {
            $it->{'now'} = 1;
        }
        elsif ((substr $it->{'date_due'}, 0, 10) le $now) {
            $it->{'overdue'} = 1;
        }
        my $dt = dt_from_string( $it->{'date_due'} );
        $it->{'date_due'} = output_pref( $dt );;
    }
    my @issues = sort { $b->{'timestamp'} <=> $a->{'timestamp'} } @$issueslist;

    my ($letter_code, %repeat);
    if ( $quickslip ) {
        $letter_code = 'ISSUEQSLIP';
        %repeat =  (
            'checkedout' => [ map {
                'biblio' => $_,
                'items'  => $_,
                'issues' => $_,
            }, grep { $_->{'now'} } @issues ],
        );
    }
    else {
        $letter_code = 'ISSUESLIP';
        %repeat =  (
            'checkedout' => [ map {
                'biblio' => $_,
                'items'  => $_,
                'issues' => $_,
            }, grep { !$_->{'overdue'} } @issues ],

            'overdue' => [ map {
                'biblio' => $_,
                'items'  => $_,
                'issues' => $_,
            }, grep { $_->{'overdue'} } @issues ],

#            'news' => [ map {
#                $_->{'timestamp'} = $_->{'newdate'};
#                { opac_news => $_ }
#            } @{ GetNewsToDisplay("slip") } ],
        );
    }
    print "%repeat: " . Dumper( \%repeat );
#    return  C4::Letters::GetPreparedLetter (
#        module => 'circulation',
#        letter_code => $letter_code,
#        branchcode => $branch,
#        tables => {
#            'branches'    => $branch,
#            'borrowers'   => $borrowernumber,
#        },
#        repeat => \%repeat,
#    );
}

islip( '', $ARGV[0], 0 ); 
