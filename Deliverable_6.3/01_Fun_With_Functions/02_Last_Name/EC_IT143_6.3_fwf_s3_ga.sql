USE [EC_IT143_DA];
GO

-- Inspect the source values before writing the last-name parsing logic.
SELECT
    t.CustomerID,
    t.ContactName
FROM dbo.t_w3_schools_customers AS t
ORDER BY t.ContactName;
GO

