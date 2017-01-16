SELECT
    itemnumber,
    biblionumber,
    title,
    issues.date_due,
    issues.returndate,
    issues.lastreneweddate,
    issues.timestamp,
    issues.issuedate
FROM
    issues
    INNER JOIN items USING (itemnumber)
    INNER JOIN biblio USING (biblionumber)
WHERE
    DATE(  issues.date_due ) = '0000-00-00'
    OR DATE( issues.returndate ) = '0000-00-00'
    OR DATE( issues.lastreneweddate ) = '0000-00-00'
    OR DATE( issues.timestamp ) = '0000-00-00'
    OR DATE( issues.issuedate ) = '0000-00-00'

