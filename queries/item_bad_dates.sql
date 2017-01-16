SELECT
    items.itemnumber,
    items.biblionumber, 
    biblio.title, 
    items.dateaccessioned, 
    items.replacementpricedate, 
    items.datelastborrowed, 
    items.datelastseen, 
    items.itemlost_on, 
    items.withdrawn_on, 
    items.timestamp, 
    items.onloan
FROM
    items 
    INNER JOIN biblio USING (biblionumber)
WHERE
    DATE(  items.dateaccessioned ) = '0000-00-00'
    OR DATE( items.replacementpricedate ) = '0000-00-00'
    OR DATE( items.datelastborrowed ) = '0000-00-00'
    OR DATE( items.datelastseen ) = '0000-00-00'
    OR DATE( items.itemlost_on ) = '0000-00-00'
    OR DATE( items.withdrawn_on ) = '0000-00-00'
    OR DATE( items.timestamp ) = '0000-00-00'
    OR DATE( items.onloan ) = '0000-00-00'

