USE [EC_IT143_DA];
GO

-- Research used:
-- https://learn.microsoft.com/en-us/sql/relational-databases/triggers/use-the-inserted-and-deleted-tables?view=sql-server-ver17
-- Confirm that the table and target column are ready before creating the trigger.

SELECT
    c.name AS column_name,
    TYPE_NAME(c.user_type_id) AS data_type,
    c.is_nullable
FROM sys.columns AS c
WHERE c.object_id = OBJECT_ID(N'dbo.t_hello_world')
  AND c.name IN (N'my_message', N'last_modified_date')
ORDER BY c.column_id;
GO

