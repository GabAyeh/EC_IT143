USE [EC_IT143_DA];
GO

-- Q: How can I extract the last name from ContactName?
-- A: Trim the name, locate the final space, and return the characters after it.
-- Example: Maria Anders -> Anders

SELECT
    'Maria Anders' AS combined_name,
    'Anders' AS expected_last_name,
    'Reverse the text, locate the first space, and keep that many characters from the right.' AS next_step;
GO

