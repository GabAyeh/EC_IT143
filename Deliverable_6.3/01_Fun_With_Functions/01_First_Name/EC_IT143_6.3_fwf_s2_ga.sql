USE [EC_IT143_DA];
GO

-- Q: How can I extract the first name from ContactName?
-- A: Trim the name, find the first space, and return the characters before it.
-- Example: Maria Anders -> Maria

SELECT
    'Maria Anders' AS combined_name,
    'Maria' AS expected_first_name,
    'Find the first space and keep the text before it.' AS next_step;
GO

