USE [EC_IT143_DA];
GO

/*****************************************************************************************************************
NAME:    EC_IT143_6.3_setup_hello_world_ga.sql
PURPOSE: Prepare dbo.t_hello_world and its trigger-tracking columns.

MODIFICATION LOG:
Ver      Date        Author          Description
-----    ----------  --------------  -----------------------------------------------------------------------------
1.0      08/04/2026  Gabriel Ayeh    Built this script for IT 143 Deliverable 6.3.

RUNTIME: Less than 1 minute

NOTES:
The checks make the script safe to rerun. The columns remain nullable so the script also works with an existing table.
******************************************************************************************************************/

IF OBJECT_ID(N'dbo.t_hello_world', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.t_hello_world
    (
        my_message       VARCHAR(100) NOT NULL
            CONSTRAINT PK_t_hello_world PRIMARY KEY,
        current_date_time DATETIME2(3) NOT NULL
            CONSTRAINT DF_t_hello_world_current_date_time DEFAULT SYSDATETIME()
    );
END;
GO

IF COL_LENGTH(N'dbo.t_hello_world', N'last_modified_date') IS NULL
BEGIN
    ALTER TABLE dbo.t_hello_world
        ADD last_modified_date DATETIME2(3) NULL;
END;
GO

IF COL_LENGTH(N'dbo.t_hello_world', N'last_modified_by') IS NULL
BEGIN
    ALTER TABLE dbo.t_hello_world
        ADD last_modified_by NVARCHAR(128) NULL;
END;
GO

SELECT
    c.column_id,
    c.name AS column_name,
    TYPE_NAME(c.user_type_id) AS data_type,
    c.max_length,
    c.is_nullable
FROM sys.columns AS c
WHERE c.object_id = OBJECT_ID(N'dbo.t_hello_world')
ORDER BY c.column_id;
GO

