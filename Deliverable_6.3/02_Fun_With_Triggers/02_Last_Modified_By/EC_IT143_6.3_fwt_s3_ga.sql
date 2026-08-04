USE [EC_IT143_DA];
GO

-- Research and test the server-user expression before putting it in the trigger.
-- Assignment resource: SUSER_NAME (Transact-SQL).

SELECT
    SUSER_NAME() AS server_user_test,
    CASE
        WHEN SUSER_NAME() IS NOT NULL THEN 'PASS'
        ELSE 'FAIL'
    END AS test_result;
GO

