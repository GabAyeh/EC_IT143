USE [EC_IT143_DA];
GO

/*****************************************************************************************************************
NAME:    dbo.trg_t_hello_world_last_mod
PURPOSE: Record when and by whom each dbo.t_hello_world row was last modified.

MODIFICATION LOG:
Ver      Date        Author          Description
-----    ----------  --------------  -----------------------------------------------------------------------------
1.0      08/04/2026  Gabriel Ayeh    Created the last-modified-date trigger.
1.1      08/04/2026  Gabriel Ayeh    Extended the trigger to record the SQL Server user.

RUNTIME: Less than 1 second for the assignment test

NOTES:
One set-based trigger keeps the two tracking values synchronized and supports multi-row updates.
The inserted table is joined through the primary key, my_message.
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
    SET
        target.last_modified_date = SYSDATETIME(),
        target.last_modified_by = SUSER_NAME()
    FROM dbo.t_hello_world AS target
    INNER JOIN inserted AS i
        ON i.my_message = target.my_message;
END;
GO

