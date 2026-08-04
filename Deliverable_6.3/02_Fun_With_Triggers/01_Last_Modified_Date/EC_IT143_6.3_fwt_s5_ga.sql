USE [EC_IT143_DA];
GO

-- Test two rows with one UPDATE. The transaction rolls back so test data is not retained.
BEGIN TRY
    BEGIN TRANSACTION;

    DELETE FROM dbo.t_hello_world
    WHERE my_message IN ('GA_DATE_TEST_1', 'GA_DATE_TEST_2');

    INSERT INTO dbo.t_hello_world (my_message)
    VALUES ('GA_DATE_TEST_1'), ('GA_DATE_TEST_2');

    SELECT
        t.my_message,
        t.last_modified_date AS value_before_update
    FROM dbo.t_hello_world AS t
    WHERE t.my_message IN ('GA_DATE_TEST_1', 'GA_DATE_TEST_2')
    ORDER BY t.my_message;

    UPDATE dbo.t_hello_world
    SET current_date_time = DATEADD(MILLISECOND, 1, current_date_time)
    WHERE my_message IN ('GA_DATE_TEST_1', 'GA_DATE_TEST_2');

    SELECT
        t.my_message,
        t.last_modified_date AS value_after_update,
        CASE
            WHEN t.last_modified_date IS NOT NULL THEN 'PASS'
            ELSE 'FAIL'
        END AS test_result
    FROM dbo.t_hello_world AS t
    WHERE t.my_message IN ('GA_DATE_TEST_1', 'GA_DATE_TEST_2')
    ORDER BY t.my_message;

    ROLLBACK TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
    THROW;
END CATCH;
GO

