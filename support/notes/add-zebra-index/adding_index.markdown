<p><style>
table
{
    border-collapse:collapse;
    width: 1200px;
}
table,th, td
{
    border: 1px solid black;
}
</style></p>


# Adding an Index to Zebra:

## Overview

In order for a bib record or authority record to be search-able within
Koha, we must add an index to Zebra. Zebra uses two protocols for indexing
its data: GRS1 and DOM. GRS1 is deprecated in favor of DOM. Unless there
are special circumstances, we will always use DOM indexing.

Koha also shares its data via two different protocols: Z39.50 and SRU. Any
zebra indexes must also be added to the configuration for these protocols,
in order for clients querying Koha's Z39.50 or SRU servers to be able
to find bibliographic information.

Once the zebra index has been added, the search options must also
display on Koha's search menus in the OPAC and staff client. Indexes
are hard-coded in C4/Search.pm, and changes must also be made to the
template tool-kit templates for OPAC and staff client.

Finally, a full zebra re-index must be run in order for the new indexes
to become available.

## Notes on deployment and upgrade.

All changes should be made in a git environment, so that changes in
configuration files may be re-applied as patches during upgrade. For
indexes added to package sites, a package must be built based on patches
created in a git environment.

Changes are *not* made directly to the configuration files used by a
running koha instance, rather, the changes are made in the git environment
then deployed to $HOME/koha-dev/ (in the case of a 'git' install) or to
the standard configuration directories used by package sites. This is
done via an install process; details will vary between git install and
and package site/gitify install.

## Files and variables

### Fields

There are esseintally three variables tracked by the koha index files:

1) Marc field -- As defined by the relevant standards body,
   e.g. <http://www.loc.gov/marc/>
2) Zebra index -- This is how Zebra and Koha refer to the zebra
   index. Index names have the form Zebra index name:Zebra index search type.
    1. Zebra index name should consiste of upper and lower case characters and dashes,
       e.g. 'Local-classification'.
    2. Zebra index search type should be 'w' (exact single word search), 'p' (exact
       phrase), 'n' (numeric) or 's' (string). Use 'w' unless you have a
       good reason not to.
3) Z39.50 Attributes -- A pre-defined set of numeric values given to
   allow Z39.50 searches. See <http://www.loc.gov/z3950/agency/bib1.html>.

Note that underscores are *not* allowed in Index names.

### Files

Unless otherwise noted, files below relative to ~/kohaclone/etc/zebradb.

+-----------------------------------------------------------+-------------------------------------------------+-----------------------+
| File Name                                                 | Purpose                                         | Environment           |
+-----------------------------------------------------------+-------------------------------------------------+-----------------------+

+-----------------------------------------------------------+-------------------------------------------------+-----------------------+
| Marc Record to zebra index name                           |                                                 |                       | 
+===========================================================+=================================================+=======================+
| ./marc_defs/marc21/biblios/record.abs                     | Associates marc field to zebra index            | GRS1 index            |
+-----------------------------------------------------------+-------------------------------------------------+-----------------------+
| ./marc_defs/marc21/biblios/biblio-koha-indexdefs.xml      | Associates marc field to zebra index            | DOM index, Source file|
+-----------------------------------------------------------+-------------------------------------------------+-----------------------+
| ./marc_defs/marc21/biblios/biblio-zebra-indexdefs.xsl     | Associates marc field to zebra index            | DOM index, xslt       |
+-----------------------------------------------------------+-------------------------------------------------+-----------------------+

+-----------------------------------------------------------+-------------------------------------------------+-----------------------+
| Z39.50 attribute to zebra index name                      |                                                 |                       |
+===========================================================+=================================================+=======================+
| ./biblios/etc/bib1.att                                    | Associates Z39.50 attribute to zebra index name | Z39.50 search         |
+-----------------------------------------------------------+-------------------------------------------------+-----------------------+
| ./ccl.properties                                          | Associates Z39.50 attribute to zebra index name | Koha search           |
+-----------------------------------------------------------+-------------------------------------------------+-----------------------+
| ./pqf.properties                                          | Associates Z39.50 attribute to zebra index name | SRU, Query Parser     |
+-----------------------------------------------------------+-------------------------------------------------+-----------------------+

+-----------------------------------------------------------+-------------------------------------------------+-----------------------+
| Koha source and template files                            | \(Source files are in their standard locations\)|                       |
+===========================================================+=================================================+=======================+
| C4/Search.pm                                              | Zebra index name must appear in getIndexes()    |                       |
+-----------------------------------------------------------+-------------------------------------------------+-----------------------+
| opac-tmpl/bootstrap/en/modules/opac-advsearch.tt          | Display index as search option in OPAC          | OPAC Advanced Search  |
+-----------------------------------------------------------+-------------------------------------------------+-----------------------+
| intranet-tmpl/prog/en/modules/catalogue/advsearch.tt      | Display index as search option in Staff Client  | Advanced Search       |
+-----------------------------------------------------------+-------------------------------------------------+-----------------------+

+-----------------------------------------------------------+-------------------------------------------------+-----------------------+
| Zebra indexing for Authority Records                      |                                                 |                       |
+===========================================================+=================================================+=======================+
| ./marc_defs/marc21/authorities/record.abs                 | Associates marc field to zebra index            |GRS1 index, authorities|
+-----------------------------------------------------------+-------------------------------------------------+-----------------------+
| ./marc_defs/marc21/authorities/authority-koha-indexdefs.xml | Associates marc field to zebra index       | DOM index, authorities src |
+-----------------------------------------------------------+-------------------------------------------------+-----------------------+
| ./marc_defs/marc21/authorities/authority-koha-indexdefs.xsl | Associates marc field to zebra index       | DOM index, authorities xslt|
+-----------------------------------------------------------+-------------------------------------------------+-----------------------+
| ./authorities/etc/bib1.att                                | Associates Z39.50 attribute to zebra index name | Z39.50 search         |
+-----------------------------------------------------------+-------------------------------------------------+-----------------------+

DOM indexing and GRS1 are mutually exclusive. Either record.abs will
be used in the case of GRS1, or \*-koha-indexdefs.xml will be used;
we will not support both. 

Zebra's indexing rules use fall-through logic, so the most general rule
should be at the end of a chain of possibly matching rules to act as
a catch-all.  For example, 022$a (ISSN) is indexed before 022:

    <index_subfields xmlns="http://www.koha-community.org/schemas/index-defs" tag="022" subfields="a">
      <target_index>ISSN:w</target_index>
      <target_index>Identifier-standard:w</target_index>
    </index_subfields>
    <index_data_field xmlns="http://www.koha-community.org/schemas/index-defs" tag="022">
      <target_index>Identifier-standard:w</target_index>
    </index_data_field>

Note that subfields are indexed using the `<index_subfields>` tag, wheras an entire marc field would be indexed using the `<index_data_field>` tag.

## Steps by step instructions for adding a new Zebra index

1. Determine whether or not we are using DOM indexing.
   If koha-conf.xml contains the following lines in the <config> section:

        <zebra_bib_index_mode>dom</zebra_bib_index_mode>
        <zebra_auth_index_mode>dom</zebra_auth_index_mode>
   Then zebra will use DOM indexing. Otherwise the site is configured
   for GRS1.  (note that the <config> section also contains mysql user,
   pass and database information; it should look familiar to you) If
   configured for GRS1, have larryb convert from GRS1 to DOM indexing.
1. Before editing any files, change directory to ~/kohaclone and run
   the following commands:

        git diff
        git status
   There should be no output from the 'git diff' command, and 'git status'
   should not show any modified files.
1. Run 'git branch'. Note which branch you are on. This will be 
   \<ORIGIONAL BRANCH NAME\> in the steps below.
1. Run 'git checkout -b "RT-XXXX"' where XXXX is the RT ticket number
   of the request to add the zebra index.
1. Determine whether you can use an already defined zebra index. 
   You may not have to add an index from scratch if Koha has an index
   that you can add to, or an un-used index.  Look in the 'getIndexes'
   subroutine of ~/kohaclone/C4/Search.pm to see which index names are
   hard-coded.  Refer to ~/kohaclone/etc/zebradb/biblios/etc/bib1.att and
   ~/kohaclone/etc/zebradb/marc\_defs/marc21/biblios/record.abs which may
   have indexes which were added, but commented out; these are typically
   good choices.
1. Run 'touch ~/kohaclone/.koha\_zebra\_index\_modified'<br />
   This will allow upgrade scripts to determine whether or not a site has
   modified index files.
1. Edit the index definitions
   Open ~/kohaclone/etc/zebradb/marc\_defs/marc21/biblios/biblio-koha-indexdefs.xml
   in a text editor.  Marc fields are specified by 'tag', subfields by
   'subfield'. Zebra index is specified using the '\<target_index\>'
   xml tag.  For example 035$a (System Control Number, often used for
   OCLC numbers), would be specified as follows:

        <index_subfields xmlns="http://www.koha-community.org/schemas/index-defs" tag="035" subfields="a">
          <target_index>Local-number:w</target_index>
          <target_index>Identifier-standard:w</target_index>
        </index_subfields>
   These lines should be added between the opening and closing \<kohaidx\>
   xml tags.
1. Choose a bib-1 (aka Z39.50) attribute -- find the closest matching attribute.
1. Edit ~/kohaclone/etc/zebradb/biblios/etc/bib1.att. The syntax is

        att bib1 attribute    Zebra index name
   In our 'OCLC Number' example, we will use 12 (bib-1 attribute 12 is
   'Local Number'), the Zebra index name already available is also
   'Local-number', so the line in bib1.att looks like this:

        att 12    Local-number
1. Edit ~/kohaclone/etc/zebradb/ccl.properties The syntax is

        Zebra index-name 1=bib1 attribute
   The string '1=' starts with the numeral 1. The ccl.properties line
   corresponding to the bib1.att record above would look like this:

        Local-number 1=12
1. If you have added a bib1 attribute and you are using SRU, you will
   have to edit ~/kohaclone/etc/zebradb/pqf.properties. This is currently
   beyond the scope of this document.
1. If you have added a new Zebra index, the Zebra index name will need 
   to be added to the getIndexes subroutine in ~/kohaclone/C4/Search.pm.
   Index names are defined in the @indexes array. The array is divided
   into three sections: biblio indexes, items indexes and subject related
   (this section is empty). Index names are alphabetical by section. The
   sections are simply for organizational purposes, it doesn't matter
   where you add the index name from a syntactic perspective. Use your
   judgement and add a comment after any element that you add to this
   array. 

        sub getIndexes{
            my @indexes = (
                            # biblio indexes
                            'ab',
                            'Abstract',
                            'acqdate',
                            'allrecords',
                            'an',
                            'Any',
        ...
1. Make new indexes searchable in opac and staff client advanced
   search. This can be done by editing the opac and staff client templates,
   or by editing intranetuserjs and opacuserjs respectively.
    #. Editing templates:
        * The syntax for a search menu item is:

                <option value="Zebra index name,Search Type">MENU TEXT</option>
          Search type is related, but not identical to 'Zebra index search type':

        +-------------------------+-------------+
        | Zebra index search type | Search type |
        +-------------------------+-------------+
        | w                       | kw, wrdl    |
        +-------------------------+-------------+
        | p                       | phr         |
        +-------------------------+-------------+
        | n                       | ?           |
        +-------------------------+-------------+
        | s                       | ?           |
        +-------------------------+-------------+

        * ~/koha-tmpl/opac-tmpl/bootstrap/en/modules/opac-advsearch.tt
        * ~/koha-tmpl/intranet-tmpl/prog/en/modules/catalogue/advsearch.tt
    1. Editing intranetuserjs, opacuserjs
        #. Add the following to intranetuserjs, with the proper substitutions:

                $(document).ready(
                    function(){ 
                        // Add MENU TEXT to advanced search
                        if (window.location.href.indexOf("catalogue/search.pl") > -1) {
                            $(".advsearch").append('<option value="Zebra index name,search type">MENU TEXT</option>');
                        }
                    }             
                );

        #. Add the following to opacuserjs, with the proper substitutions:

                $(document).ready(
                    function(){ 
                        // Add MENU TEXT to advanced search
                        if (window.location.href.indexOf("koha/opac-search.pl") > -1) {
                            $(".advsearch").append('<option value="Zebra index name,search type">MENU TEXT</option>');
                        }
                    }             
                );

           *IMPORTANT: if the search type is 'w', the comma and the search type are omitted:* use `<option value="Other-control-number">` not `<option value="Other-control-number,w">`

           Note that '$(document).ready' and 'function()' blocks may already be present in intranetuserjs or opacuserjs, in which case the 'if()' statement may simply be inserted into the function() block.

1. Commit changes to git
    1. run 'git status' this should show a list of the files that you have modified.
    1. run 'git add' for each modified file.
    1. run 'git commit -m 'my message''. The message should be in the form
       '@RT \<RT ticket#\>: \<SITE NAME\>: Add zebra index for \<PURPOSE OF INDEX\> at \<MARC FIELD\> \<SUBFIELD\>', 
       e.g. '@RT 17200: aarome: Add zebra index for OCLC number at 035 a'. 
       Note that the '$' marc subfield delimiter has been replaced with a space, 
       in order to avoid accidental issues with shell variable expansion.
    1. run 'git format-patch HEAD~1'
    1. Note the name of the generated patch.
    1. Copy the patch to ~/bwspatches
    1. Run 'git checkout \<ORIGINAL BRANCH NAME\>'
    1. Add a note to [system.upgrade_schedules](https://docs.google.com/a/bywatersolutions.com/spreadsheet/ccc?key=0Au16RCbfheUwdGJNd05NOGlHeHVVN1JDMS1rNGpIRGc&usp=drive_web#gid=0)
        1. Document the RT ticket number
        1. Document the name of the patch
        1. Document the index being added
        1. Document any special notes for whoever is running upgrades/applying patches.
1. The following steps will need to be taken either on first install or on upgrade:
    1. Run 'git am -3 [0001-this-is-my-patch].patch'
    1. Install the changes made in ~/kohaclone to the running koha environment.
        1. The steps will vary between a git install and a
           gitified package install, but should look similar to
           [these](http://wiki.koha-community.org/wiki/MRenvoize/Updating_Koha_Install).
        1. biblio-zebra-indexdefs.xsl must be re-generated after
           koha-indexdefs-to-zebra.xsl is edited.
           In a package install, \$PATH_TO_ZEBRA_INDEXDEFS will be
           '/etc/koha/zebradb/marc_defs/marc21/biblios'. For a git install,
           use \$HOME/koha-dev/etc/zebradb/marc_defs/marc21/biblios instead.

                /usr/bin/xsltproc ~/kohaclone/etc/zebradb/xsl/koha-indexdefs-to-zebra.xsl \
                ~/kohaclone/etc/zebradb/marc_defs/marc21/biblios/biblio-koha-indexdefs.xml  \
                >  $PATH_TO_ZEBRA_INDEXDEFS/biblio-zebra-indexdefs.xsl
    1. A full zebra rebuild is necessary after any index is added.

## Location of Zebra configuration files
After deployment, view the file pointed to by `$KOHA_CONF`, and look for

    <serverinfo id="biblioserver">
            <ccl2rpn>/etc/koha/zebradb/ccl.properties</ccl2rpn>

The path pointed to in the `ccl2rpn` tag (in this case /etc/koha/zebradb) is the location of all zebra configuration files.

Relative to this path, here are the locations of the files:

    ./ccl.properties
    ./biblios/etc/bib1.att
    ./marc_defs/marc21/biblios/biblio-koha-indexdefs.xml
    ./marc_defs/marc21/biblios/biblio-zebra-indexdefs.xsl

These files will probably be symbolic links created by the install process.

## Community resources:
[ashimema's zebra wiki page](http://wiki.koha-community.org/wiki/MRenvoize/zebra)
