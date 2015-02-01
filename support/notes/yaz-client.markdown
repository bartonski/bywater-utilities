# Running Yaz-client

The values of `$socketname` are either `bibliosocket` or `authoritysocket`

`yaz-client unix:/home/$USER/koha-dev/var/run/zebradb/$socketname`

This will give you the a `Z>` prompt. Once at the prompt:

    Z> use biblios
    Z> f twain

If you want to search on a particular index, use 'scan':

    Z> scan @attr 1=4 John                                                                                                                                        
    query: @attr 1=4 John
    Received ScanResponse
    20 entries, position=1
    * John (11491)
      Johna (1)
      Johner (1)
      Johnes (3)
      Johnice (8)
      Johnland (3)
      Johnny (5)
      Johns (58)
      Johns̓ (1)
      Johnson (611)
      Johnsonian (2)
      Johnsrud (1)
      Johnsson (1)
      Johnston (91)
      Johnstone (16)
      Johnstoni (1)
      Johnstoun (5)
      Johnstown (1)
      Johrendt (4)
      Johs (5)
    Elapsed: 0.139494

Search ccl.properties for the correct value of `@attr`

## Listing indexes:

Courtesy of a [conversation with dcook and tcohen in irc](http://irc.koha-community.org/koha/2014-10-29#i_1588267)

Marc indexes can be listed as follows:

First, check that zebradb/retrieval-info-bib-dom.xml contains the following text:

    <?xml version="1.0" encoding="UTF-8"?>
    <retrievalinfo xmlns="http://indexdata.com/yaz">
      <retrieval syntax="marc21" name="F">
        <backend syntax="xml" name="marc">
          <marc inputformat="xml" outputformat="marc"
                inputcharset="utf-8"
                outputcharset="utf-8"/>
        </backend>
      </retrieval>
      <retrieval syntax="marc21" name="B">
        <backend syntax="xml" name="marc">
          <marc inputformat="xml" outputformat="marc"
                inputcharset="utf-8"
                outputcharset="utf-8"/>
        </backend>
      </retrieval>
      <retrieval syntax="xml" name="index"/> <!-- allow viewing index entries -->
      <retrieval syntax="xml" name="marc"
                 identifier="info:srw/schema/1/marcxml-v1.1"/>
      <retrieval syntax="xml" name="marcxml"
                 identifier="info:srw/schema/1/marcxml-v1.1"/>
    </retrievalinfo>

Then issue the following commands to yaz-client:
* base biblios
* f test
* format xml
* show

The results look like this:

    Z> base biblios
    Z> f test
    Sent searchRequest.
    Received SearchResponse.
    Search was a success.
    Number of hits: 99, setno 1
    SearchResult-1: term=test cnt=99
    records returned: 0
    Elapsed: 0.006331
    Z> format xml
    Z> show
    Sent presentRequest (1+1).
    Records: 1
    [biblios]Record type: XML
    <?xml version="1.0" encoding="UTF-8"?>
    <z:record xmlns:z="http://indexdata.com/zebra-2.0" xmlns:marc="http://www.loc.gov/MARC21/slim" xmlns:kohaidx="http://www.koha-community.org/schemas/index-defs
    " type="update" z:id="1">
      <z:index name="llength:w">     </z:index>
      <z:index name="rtype:w">a</z:index>
      <z:index name="Bib-level:w">m</z:index>
      <z:index name="Date/time-last-modified:w">20141017152725.0</z:index>
      <z:index name="date-entered-on-file:n">14100</z:index>
      <z:index name="date-entered-on-file:s">14100</z:index>
      <z:index name="pubdate:w">    </z:index>
      <z:index name="pubdate:n">    </z:index>
      <z:index name="pubdate:y">    </z:index>
      <z:index name="pubdate:s">    </z:index>
      <z:index name="pl:w">xxu</z:index>
      <z:index name="ta:w">|</z:index>
    ...

If you add `elements marcxml` before `show`, you will see the MARCXML entities for the first matching record:

    Z> base biblios
    Z> f test
    ...
    Z> elements marcxml
    Z> show
    Sent presentRequest (1+1).
    Records: 1
    [biblios]Record type: XML
    <?xml version="1.0" encoding="UTF-8"?>
    <record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.loc.gov/MARC21/slim" xsi:schemaLocation="http://www.loc.gov/MARC21/slim http:/
    /www.loc.gov/standards/marcxml/schema/MARC21slim.xsd">

      <leader>     nam a22     7a 4500</leader>
      <controlfield tag="003">TxPlISD</controlfield>
      <controlfield tag="005">20141017152725.0</controlfield>
      <controlfield tag="008">141009b        xxu||||| |||| 00| 0 eng d</controlfield>
      <datafield tag="035" ind1=" " ind2=" ">
        <subfield code="a">ocm03545607</subfield>
      </datafield>
      <datafield tag="040" ind1=" " ind2=" ">
        <subfield code="a">TxPlISD</subfield>
        <subfield code="c">TxPlISD</subfield>
      </datafield>
      <datafield tag="245" ind1=" " ind2=" ">
        <subfield code="a">Test record for 12229 Add zebra index for OCLC number at 035$a</subfield>
        <subfield code="b">035$a: ocm03545607</subfield>
      </datafield>
      <datafield tag="500" ind1=" " ind2=" ">
        <subfield code="a">Record to be used for ByWater Solutions trouble-shooting. There is no physical book with this title. Please do not delete this record.<
    /subfield>
      </datafield>
      <datafield tag="942" ind1=" " ind2=" ">
        <subfield code="2">ddc</subfield>
        <subfield code="c">BK</subfield>
      </datafield>
      <datafield tag="999" ind1=" " ind2=" ">
        <subfield code="c">1</subfield>
        <subfield code="d">1</subfield>
      </datafield>
    </record>
    nextResultSetPosition = 2
    Elapsed: 0.053172

