USE [EC_IT143_DA];
GO

-- Compare the ad hoc calculation and scalar-function result side by side.
SELECT
    t.ContactName,
    LEFT(
        LTRIM(RTRIM(t.ContactName)),
        CHARINDEX(' ', LTRIM(RTRIM(t.ContactName)) + ' ') - 1
    ) AS ad_hoc_first_name,
    dbo.udf_parse_first_name(t.ContactName) AS udf_first_name
FROM dbo.t_w3_schools_customers AS t
ORDER BY t.ContactName;
GO

