USE [EC_IT143_DA];
GO

/*****************************************************************************************************************
NAME:    dbo.trg_t_hello_world_last_mod
PURPOSE: Record when each updated dbo.t_hello_world row was last modified.

MODIFICATION LOG:
Ver      Date        Author          Description
-----    ----------  --------------  -----------------------------------------------------------------------------
1.0      08/04/2026  Gabriel Ayeh    Built this AFTER UPDATE trigger for IT 143 Deliverable 6.3.

RUNTIME: Less than 1 second for the assignment test

NOTES:
The inserted table makes the trigger set-based, so it handles single-row and multi-row updates.
Source: https://learn.microsoft.com/en-us/sql/relational-databases/triggers/use-the-inserted-and-deleted-tables?view=sql-server-ver17
******************************************************************************************************************/

CREATE OR ALTER TRIGGER dbo.trg_t_hello_world_last_mod
ON dbo.t_hello_world
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Prevent the tracking UPDATE below from repeatedly invoking this trigger.
    IF TRIGGER_NESTLEVEL() > 1
        RETURN;

    UPDATE target
    SET target.last_modified_date = SYSDATETIME()
    FROM dbo.t_hello_world AS target
    INNER JOIN inserted AS i
        ON i.my_message = target.my_message;
END;
GO

