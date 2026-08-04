USE [EC_IT143_DA];
GO

-- The first-name function is complete, so restart the method with a new question.
-- Next question: How can I extract the last name from ContactName?

SELECT
    t.CustomerID,
    t.ContactName,
    dbo.udf_parse_first_name(t.ContactName) AS first_name,
    CAST('' AS VARCHAR(500)) AS last_name_to_solve
FROM dbo.t_w3_schools_customers AS t
ORDER BY t.ContactName;
GO

