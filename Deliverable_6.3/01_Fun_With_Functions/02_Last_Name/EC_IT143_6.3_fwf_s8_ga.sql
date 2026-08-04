USE [EC_IT143_DA];
GO

-- Both required functions are complete.
-- Next question: How could the functions preserve multi-word surnames or handle unusual spacing?

SELECT
    t.CustomerID,
    t.ContactName,
    dbo.udf_parse_first_name(t.ContactName) AS first_name,
    dbo.udf_parse_last_name(t.ContactName) AS last_name
FROM dbo.t_w3_schools_customers AS t
ORDER BY t.ContactName;
GO

