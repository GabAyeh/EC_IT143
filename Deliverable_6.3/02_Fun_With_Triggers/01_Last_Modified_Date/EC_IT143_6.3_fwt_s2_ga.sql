USE [EC_IT143_DA];
GO

-- Q: How can I keep track of when a record was last modified?
-- A: Use an AFTER UPDATE trigger to set last_modified_date for every updated row.
-- A default constraint can populate an INSERT, but it does not refresh the value after an UPDATE.

SELECT
    'AFTER UPDATE trigger' AS proposed_solution,
    'Use the inserted table to identify all affected rows.' AS next_step;
GO

