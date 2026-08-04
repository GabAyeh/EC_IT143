USE [EC_IT143_DA];
GO

-- Research used:
-- https://learn.microsoft.com/en-us/sql/t-sql/functions/charindex-transact-sql?view=sql-server-ver17
-- Test the solution as an ad hoc query before creating a function.

SELECT
    t.ContactName,
    LEFT(
        LTRIM(RTRIM(t.ContactName)),
        CHARINDEX(' ', LTRIM(RTRIM(t.ContactName)) + ' ') - 1
    ) AS ad_hoc_first_name
FROM dbo.t_w3_schools_customers AS t
ORDER BY t.ContactName;
GO

