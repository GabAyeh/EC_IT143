USE [EC_IT143_DA];
GO

/*****************************************************************************************************************
NAME:    dbo.udf_parse_first_name
PURPOSE: Return the first word from a combined contact name.

MODIFICATION LOG:
Ver      Date        Author          Description
-----    ----------  --------------  -----------------------------------------------------------------------------
1.0      08/04/2026  Gabriel Ayeh    Built this scalar function for IT 143 Deliverable 6.3.

RUNTIME: Less than 1 second

NOTES:
CHARINDEX locates the first space. Appending a space also supports single-word names.
Source: https://learn.microsoft.com/en-us/sql/t-sql/functions/charindex-transact-sql?view=sql-server-ver17
******************************************************************************************************************/

CREATE OR ALTER FUNCTION dbo.udf_parse_first_name
(
    @combined_name VARCHAR(500)
)
RETURNS VARCHAR(500)
AS
BEGIN
    DECLARE @clean_name VARCHAR(500);
    DECLARE @first_name VARCHAR(500);

    SET @clean_name = LTRIM(RTRIM(@combined_name));
    SET @first_name = LEFT(
        @clean_name,
        CHARINDEX(' ', @clean_name + ' ') - 1
    );

    RETURN @first_name;
END;
GO

SELECT dbo.udf_parse_first_name('Maria Anders') AS function_test;
GO

