USE [EC_IT143_DA];
GO

/*****************************************************************************************************************
NAME:    EC_IT143_6.3_setup_materialize_ga.sql
PURPOSE: Materialize dbo.v_w3_schools_customers as dbo.t_w3_schools_customers.

MODIFICATION LOG:
Ver      Date        Author          Description
-----    ----------  --------------  -----------------------------------------------------------------------------
1.0      08/04/2026  Gabriel Ayeh    Built this script for IT 143 Deliverable 6.3.

RUNTIME: Less than 1 minute

NOTES:
Run dbo.v_w3_schools_customers.sql before this script. SELECT INTO creates the table only when it does not exist.
******************************************************************************************************************/

IF OBJECT_ID(N'dbo.v_w3_schools_customers', N'V') IS NULL
BEGIN
    THROW 50001, 'Create dbo.v_w3_schools_customers before running this script.', 1;
END;
GO

IF OBJECT_ID(N'dbo.t_w3_schools_customers', N'U') IS NULL
BEGIN
    SELECT v.*
    INTO dbo.t_w3_schools_customers
    FROM dbo.v_w3_schools_customers AS v;

    PRINT 'dbo.t_w3_schools_customers was created from the view.';
END
ELSE
BEGIN
    PRINT 'dbo.t_w3_schools_customers already exists. No table was created.';
END;
GO

SELECT COUNT(*) AS customer_row_count
FROM dbo.t_w3_schools_customers;
GO

