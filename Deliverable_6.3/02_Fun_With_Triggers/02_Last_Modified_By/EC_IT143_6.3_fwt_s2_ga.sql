USE [EC_IT143_DA];
GO

-- Q: How can I keep track of who last modified a record?
-- A: Extend the AFTER UPDATE trigger to store SUSER_NAME() in last_modified_by.

SELECT
    SUSER_NAME() AS current_server_user,
    'Add this value to the set-based AFTER UPDATE trigger.' AS next_step;
GO

