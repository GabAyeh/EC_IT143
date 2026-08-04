USE [EC_IT143_DA];
GO

-- Expected result: 0 rows. Any returned row represents a mismatch.
WITH first_name_check AS
(
    SELECT
        t.CustomerID,
        t.ContactName,
        LEFT(
            LTRIM(RTRIM(t.ContactName)),
            CHARINDEX(' ', LTRIM(RTRIM(t.ContactName)) + ' ') - 1
        ) AS ad_hoc_first_name,
        dbo.udf_parse_first_name(t.ContactName) AS udf_first_name
    FROM dbo.t_w3_schools_customers AS t
)
SELECT
    c.CustomerID,
    c.ContactName,
    c.ad_hoc_first_name,
    c.udf_first_name
FROM first_name_check AS c
WHERE ISNULL(c.ad_hoc_first_name, '<NULL>')
    <> ISNULL(c.udf_first_name, '<NULL>');
GO

