#!/bin/bash

## TODO: use getopt
## TODO: take format as an argument (default to marcxml)

opacurl="${1}"
shift
for bibnum in "$@" 
do
        export="cgi-bin/koha/opac-export.pl"
        exportargs="op=export&bib=${bibnum}&format=marcxml"
        marc_xml_file="$bibnum.marc.xml"
        wget "${opacurl}/${export}?${exportargs}" -O $marc_xml_file
done

