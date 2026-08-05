/*****************************************************************************************************************
NAME:    W6_4_Performance_Analysis.sql
PURPOSE: Demonstrate basic SQL Server performance analysis by reviewing actual execution plans, identifying
         missing-index recommendations, creating nonclustered indexes, and comparing estimated subtree costs.

MODIFICATION LOG:
Ver     Date        Author          Description
-----   ----------  --------------  ------------------------------------------------------------------------------
1.0     08/05/2026  Gabriel Ayeh    Created the Week 6.4 performance-analysis deliverable.

RUNTIME:
Less than one minute in the AdventureWorks2022 sample database.

NOTES:
Before running the original queries, select Query > Include Actual Execution Plan in SSMS or press Ctrl+M.
The cost values documented below were observed in Gabriel's local AdventureWorks2022 database.
The IF NOT EXISTS checks prevent errors if the script is run again after the indexes have already been created.
******************************************************************************************************************/

USE [AdventureWorks2022];
GO

SET STATISTICS IO ON;
SET STATISTICS TIME ON;
GO

/*
QUERY 1: Find addresses located in Bothell.
TABLE: Person.Address
UNINDEXED FILTER COLUMN: City

BEFORE INDEX:
- Execution-plan operations: Index Scan and Key Lookup
- Missing-index estimated impact: 91.0545%
- Estimated Subtree Cost: 0.217106
*/

SELECT pa.*
FROM Person.Address AS pa
WHERE pa.City = N'Bothell';
GO

/* Create the nonclustered index recommended for Query 1. */

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE object_id = OBJECT_ID(N'Person.Address')
      AND name = N'IX_Address_City_W64'
)
BEGIN
    CREATE NONCLUSTERED INDEX [IX_Address_City_W64]
        ON [Person].[Address] ([City]);
END;
GO

/*
QUERY 1 AFTER INDEX:
- Execution-plan operation: Index Seek
- Estimated Subtree Cost: 0.0305711
- Estimated cost reduction: approximately 85.92%
*/

SELECT pa.*
FROM Person.Address AS pa
WHERE pa.City = N'Bothell';
GO

/*
QUERY 2: Find sales-order details with a specific carrier tracking number.
TABLE: Sales.SalesOrderDetail
UNINDEXED FILTER COLUMN: CarrierTrackingNumber

BEFORE INDEX:
- Execution-plan operation: Clustered Index Scan
- Missing-index estimated impact: 99.6584%
- Estimated Subtree Cost: 1.07359
*/

SELECT sod.*
FROM Sales.SalesOrderDetail AS sod
WHERE sod.CarrierTrackingNumber = N'4911-403C-98';
GO

/* Create the nonclustered index recommended for Query 2. */

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE object_id = OBJECT_ID(N'Sales.SalesOrderDetail')
      AND name = N'IX_SalesOrderDetail_CarrierTrackingNumber_W64'
)
BEGIN
    CREATE NONCLUSTERED INDEX [IX_SalesOrderDetail_CarrierTrackingNumber_W64]
        ON [Sales].[SalesOrderDetail] ([CarrierTrackingNumber]);
END;
GO

/*
QUERY 2 AFTER INDEX:
- Execution-plan operations: Index Seek and Key Lookup
- Estimated Subtree Cost: 0.0255944
- Estimated cost reduction: approximately 97.62%
*/

SELECT sod.*
FROM Sales.SalesOrderDetail AS sod
WHERE sod.CarrierTrackingNumber = N'4911-403C-98';
GO

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
GO
