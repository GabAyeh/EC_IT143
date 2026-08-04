USE [EC_IT143_DA];
GO

-- Expected result: 0 rows. Any returned row represents a mismatch.
WITH last_name_check AS
(
    SELECT
        t.CustomerID,
        t.ContactName,
        RIGHT(
            LTRIM(RTRIM(t.ContactName)),
            CHARINDEX(' ', REVERSE(LTRIM(RTRIM(t.ContactName))) + ' ') - 1
        ) AS ad_hoc_last_name,
        dbo.udf_parse_last_name(t.ContactName) AS udf_last_name
    FROM dbo.t_w3_schools_customers AS t
)
SELECT
    c.CustomerID,
    c.ContactName,
    c.ad_hoc_last_name,
    c.udf_last_name
FROM last_name_check AS c
WHERE ISNULL(c.ad_hoc_last_name, '<NULL>')
    <> ISNULL(c.udf_last_name, '<NULL>');
GO

