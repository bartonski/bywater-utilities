## Location of configuration files

    ZEBRA_BIBLIOS_DOM="$(grep zebra-biblios-dom.cfg $KOHA_CONF | sort -u | sed -e 's|[[:space:]]*</*config>||g')"
    grep profilePath $ZEBRA_BIBLIOS_DOM | cut -d : -f2- | sed "s/:/\n/g"
    for path in $(grep profilePath $ZEBRA_BIBLIOS_DOM | cut -d : -f2- | sed "s/:/\n/g"); do find $path ! -type d; done

Should look something like this:

    /home/barton/koha-dev/etc/zebradb/biblios/etc/dom-config-marc.xml
    /home/barton/koha-dev/etc/zebradb/biblios/etc/dom-config.xml
    /home/barton/koha-dev/etc/zebradb/biblios/etc/bib1.att
    /home/barton/koha-dev/etc/zebradb/etc/numeric.chr
    /home/barton/koha-dev/etc/zebradb/etc/explain.tag
    /home/barton/koha-dev/etc/zebradb/etc/tagsetm.tag
    /home/barton/koha-dev/etc/zebradb/etc/urx.chr
    /home/barton/koha-dev/etc/zebradb/etc/word-phrase-utf.chr
    /home/barton/koha-dev/etc/zebradb/etc/explain.abs
    /home/barton/koha-dev/etc/zebradb/etc/normarc.mar
    /home/barton/koha-dev/etc/zebradb/etc/explain.att
    /home/barton/koha-dev/etc/zebradb/etc/default.idx
    /home/barton/koha-dev/etc/zebradb/etc/marc21.mar
    /home/barton/koha-dev/etc/zebradb/etc/gils.att
    /home/barton/koha-dev/etc/zebradb/etc/usmarc.mar
    /home/barton/koha-dev/etc/zebradb/etc/words-icu.xml
    /home/barton/koha-dev/etc/zebradb/etc/unimarc.mar
    /home/barton/koha-dev/etc/zebradb/etc/passwd
    /home/barton/koha-dev/etc/zebradb/marc_defs/marc21/biblios/biblio-koha-indexdefs.xml
    /home/barton/koha-dev/etc/zebradb/marc_defs/marc21/biblios/record.abs
    /home/barton/koha-dev/etc/zebradb/marc_defs/marc21/biblios/biblio-zebra-indexdefs.xsl
    /home/barton/koha-dev/etc/zebradb/lang_defs/en/sort-string-utf.chr
    /home/barton/koha-dev/etc/zebradb/xsl

In particular, `bib1.att` should be in the path, and should contain the zebra index definitions that you're searching for. 

You can find where `ccl.propterties` is located using the following command:

    grep 'ccl2rpn' $KOHA_CONF

The output should look something like this:

        <ccl2rpn>/home/barton/koha-dev/etc/zebradb/ccl.properties</ccl2rpn>
    <ccl2rpn>/home/barton/koha-dev/etc/zebradb/ccl.properties</ccl2rpn>
        <ccl2rpn>/home/barton/koha-dev/etc/zebradb/ccl.properties</ccl2rpn>

