#! /usr/bin/perl

# Usage:
#
# generate-zebra-config.pl YAML-FILE
#
#
# This tool takes a yaml file as its only argument, 
# consisting of the following:
# 
# A hash of arrays, called 'indexes'
# Each element of the array is a hash containing the
# following fields:
#   index_name
#   index_type
#   tag
#   z3950_attribute
#   subfields [Optional] 
#   menu_title
# 
# The 'subfields' element is an array, containing all
# possible subfields.
#
# Here is an example yaml file.
# ---
# indexes:
#   - index_name: bibliographic_reference
#     index_type: w
#     subfields:
#       - a
#       - c
#     tag: 510
#     z3950_attribute: 1068
#     menu_title: Bibliographic Reference
#   - index_name: publisher_location
#     index_type: w
#     subfields:
#       - e
#     tag: 260
#     z3950_attribute: 59
#     menu_title: Publisher Location
# 
# The program will then create the following files:
#
# /tmp/zebra-conf.Search.pm.txt
# /tmp/zebra-conf.bib1.att.txt
# /tmp/zebra-conf.biblio-koha-indexdefs.xml.txt
# /tmp/zebra-conf.ccl.properties.txt
# /tmp/zebra-conf.record.abs.txt
# 
# Each file is generated using the templates
# contained in the %templates hash below.

# TODO: Use Pod2usage for documentation and usage.
# TODO: Use Getopt::Long for commandline option handling.
# TODO: Might be possible to clean up templates by moving
#         logic for missing subfields into the body of
#         the code.

use strict;
use warnings;

use Template;
use YAML;

my $data= YAML::LoadFile $ARGV[0];
for my $record ( @{$data->{indexes}} ) {
    # In the javascript menu entries,
    # record type is ommitted if it is 'w'.
    $record->{menu_index_type} = 
        ( $record->{index_type} eq 'w' ) 
        ? '' 
        : ",$record->{index_type}";
}

my %templates = (
'record.abs' =>
'[% FOREACH index IN indexes %][% IF index.subfields %][% FOREACH subfield IN index.subfields %]melm [% index.tag %]$[% subfield %]     [% index.index_name %]:[% index.index_type %]
[% END %][%END%]melm [% index.tag %]       [% index.index_name %]:[% index.index_type %]
[% END%]
',

'biblio-koha-indexdefs.xml' =>
'[% FOREACH index IN indexes %][% IF index.subfields %][% FOREACH subfield IN index.subfields %]  <index_subfields tag="[% index.tag %]" subfields="[% subfield %]">
    <target_index>[% index.index_name %]:[% index.index_type %]</target_index>
  </index_subfields>
[% END %][%END%]  <index_data_field tag="[% index.tag %]">
    <target_index>[% index.index_name %]:[% index.index_type %]</target_index>
  </index_data_field>
[%END%]

',

'bib1.att' =>
'[% FOREACH index IN indexes %]att [% index.z3950_attribute %]    [% index.index_name %]
[% END %]',
 
'ccl.properties' =>
'[% FOREACH index IN indexes %][% index.index_name %] 1=[% index.z3950_attribute %]
[% END %]',

'Search.pm' =>
q([% FOREACH index IN indexes %]                    '[% index.index_name %]',
[% END %]),

'opac-advsearch.tt' =>
q|$(document).ready(function(){
[% FOREACH index IN indexes %]
    // Add [% index.index_name %]  to advanced search
    if (window.location.href.indexOf("koha/opac-search.pl") > -1) {
        $(".advsearch").append('<option value="[% index.index_name %][% index.menu_index_type %]">[% index.menu_title %]</option>');
    }
[%END%]
});
|,

'advsearch.tt' =>
q|$(document).ready(function(){
[% FOREACH index IN indexes %]
    // Add [% index.index_name %]  to advanced search
    if (window.location.href.indexOf("catalogue/search.pl") > -1) {
        $(".advsearch").append('<option value="[% index.index_name %][% index.menu_index_type %]">[% index.menu_title %]</option>');
    }
[%END%]
});
|,
);

my $config = {};

# create Template object
my $template = Template->new($config) or die "$Template::ERROR";

for my $tt ( keys %templates ) {
    my $file = "/tmp/zebra-conf.$tt.txt";
    my $tmpl = $templates{$tt};
    print "Processing file '$file'\n";
    $template->process( \$tmpl, $data, $file ) or die $template->error(), "\n";
}

