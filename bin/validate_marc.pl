#! /usr/bin/perl

use warnings;
use strict;
use Modern::Perl;
use C4::Context($ENV{KOHA_CONF});
use LWP::Simple;
use MARC::Record;
use MARC::File::XML;

my $OPACBaseURL = "http://" . C4::Context->preference("OPACBaseURL");
my $export = "cgi-bin/koha/opac-export.pl";

say "OPACBaseURL: '$OPACBaseURL'";

BIBRECORD: for my $bibnum ( @ARGV ) {
    my $export_args="op=export&bib=${bibnum}&format=marcxml";
    my $url = "Getting '${OPACBaseURL}/${export}?${export_args}'";
    say "$url";
    my $marc_xml = LWP::Simple::get $url;
    say "creating marc record for Biblio number '$bibnum'";

    my $marc_flavor=C4::Context->preference('marcflavour');
    print "Marc flavor '$marc_flavor'";
    MARC::File::XML->default_record_format($marc_flavor);
    my $marc_record = MARC::Record->new();

    if ($marc_xml) {
        $marc_record = eval { MARC::Record::new_from_xml( $marc_xml, "utf8", $marcflavour ) };
        if ($@) { warn " problem with :$bibnum : $@ \n$marc_xml"; }
        next BIBRECORD unless $marc_record;
    }

    say "Encoding: '" . $marc_record->encoding()                   . "'";
    say "Warnings: '" . join( qq{','},  $marc_record->warnings() ) . "'"; 
}

# #!/bin/bash
# 
# opacurl="${1}"
# shift
# for bibnum in "$@" 
# do
#         export="cgi-bin/koha/opac-export.pl"
#         exportargs="op=export&bib=${bibnum}&format=marcxml"
#         marc_xml_file="$bibnum.marc.xml"
#         wget "${opacurl}/${export}?${exportargs}" -O $marc_xml_file
# done
