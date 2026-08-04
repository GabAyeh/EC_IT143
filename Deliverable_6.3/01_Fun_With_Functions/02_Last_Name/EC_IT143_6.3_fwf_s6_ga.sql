USE [EC_IT143_DA];
GO

-- Compare the ad hoc calculation and scalar-function result side by side.
SELECT
    t.ContactName,
    RIGHT(
        LTRIM(RTRIM(t.ContactName)),
        CHARINDEX(' ', REVERSE(LTRIM(RTRIM(t.ContactName))) + ' ') - 1
    ) AS ad_hoc_last_name,
    dbo.udf_parse_last_name(t.ContactName) AS udf_last_name
FROM dbo.t_w3_schools_customers AS t
ORDER BY t.ContactName;
GO

