SELECT
    letter_number,
    branchcode,
    categorycode,
    delay,      
    letter_code,
    debarred
FROM
   (
            SELECT
                '1' AS letter_number, branchcode, categorycode,
                delay1 AS delay, letter1 AS letter_code,
                debarred1 AS debarred
            FROM overduerules
        UNION
            SELECT
                '2' AS letter_number, branchcode, categorycode,
                delay2 AS delay, letter2 AS letter_code,
                debarred2 AS debarred
            FROM overduerules
        UNION
            SELECT
                '3' AS letter_number, branchcode, categorycode,
                delay3 AS delay, letter3 AS letter_code,
                debarred3 AS debarred
            FROM overduerules
   ) AS odr
