/*****************************************************************************************************************
NAME:    EC_IT143_W3.4_GA_AdventureWorks_Answers.sql

PURPOSE:
Answer business and metadata questions using the AdventureWorks2022 sample database.

MODIFICATION LOG:
Ver      Date         Author          Description
-----   ----------   -------------   -------------------------------------------------------------------------------
1.0     07/18/2026   Gabriel Ayeh    Built this script for EC IT143 Week 3.4 AdventureWorks Create Answers.

RUNTIME:
Approximately 15 seconds

NOTES:
This script answers eight AdventureWorks questions selected from the Week 3.3
discussion assignment. The queries demonstrate filtering, sorting, joins,
aggregation, grouping, ranking, date functions, and the use of
INFORMATION_SCHEMA views.

******************************************************************************************************************/

/*****************************************************************************************************************
Q1
Author: Gabriel Ayeh

Question:
What are the ten most expensive products based on their list price?

Answer:
Return the ten products with the highest list prices from the
Production.Product table.
******************************************************************************************************************/

SELECT TOP (10)
       ProductID,
       Name AS ProductName,
       ListPrice
FROM Production.Product
ORDER BY ListPrice DESC;
GO


/*****************************************************************************************************************
Q2
Author: Gabriel Ayeh

Question:
Which employees have the job title of Sales Representative?

Answer:
Return all employees whose job title is Sales Representative.
******************************************************************************************************************/

SELECT
       e.BusinessEntityID,
       p.FirstName,
       p.LastName,
       e.JobTitle
FROM HumanResources.Employee AS e
INNER JOIN Person.Person AS p
    ON e.BusinessEntityID = p.BusinessEntityID
WHERE e.JobTitle = 'Sales Representative'
ORDER BY p.LastName,
         p.FirstName;
GO


/*****************************************************************************************************************
Q3
Author: Domkat Stephen

Question:
I want to monitor order timing patterns. Which days of the week have the highest
number of orders? Use SalesOrderHeader and group results to identify peak ordering
days.

Answer:
Count the number of sales orders placed on each day of the week.
******************************************************************************************************************/

SELECT
       DATENAME(WEEKDAY, OrderDate) AS OrderDay,
       COUNT(SalesOrderID) AS TotalOrders
FROM Sales.SalesOrderHeader
GROUP BY
       DATENAME(WEEKDAY, OrderDate),
       DATEPART(WEEKDAY, OrderDate)
ORDER BY TotalOrders DESC;
GO


/*****************************************************************************************************************
Q4
Author: Domkat Stephen

Question:
We are reviewing discount usage. Which products receive the highest total discount
amounts? Combine SalesOrderDetail and Product, then rank products by total
discount applied.

Answer:
Calculate the total discount amount for each product and return the highest values.
******************************************************************************************************************/

SELECT TOP (10)
       p.ProductID,
       p.Name AS ProductName,
       SUM(sod.UnitPriceDiscount * sod.UnitPrice * sod.OrderQty) AS TotalDiscount
FROM Sales.SalesOrderDetail AS sod
INNER JOIN Production.Product AS p
    ON sod.ProductID = p.ProductID
GROUP BY
       p.ProductID,
       p.Name
ORDER BY TotalDiscount DESC;
GO


/*****************************************************************************************************************
Q5
Author: Yemiode Iwara

Question:
A human resources analyst wants to evaluate sales performance by employees.
Using the SalesPerson, SalesOrderHeader, and Employee tables, determine which
employees generated the highest sales revenue.

Answer:
Calculate total sales revenue for each salesperson and rank them from highest
to lowest.
******************************************************************************************************************/

SELECT
       e.BusinessEntityID,
       p.FirstName,
       p.LastName,
       SUM(soh.TotalDue) AS TotalSalesRevenue
FROM Sales.SalesPerson AS sp
INNER JOIN HumanResources.Employee AS e
    ON sp.BusinessEntityID = e.BusinessEntityID
INNER JOIN Person.Person AS p
    ON e.BusinessEntityID = p.BusinessEntityID
INNER JOIN Sales.SalesOrderHeader AS soh
    ON sp.BusinessEntityID = soh.SalesPersonID
GROUP BY
       e.BusinessEntityID,
       p.FirstName,
       p.LastName
ORDER BY TotalSalesRevenue DESC;
GO


/*****************************************************************************************************************
Q6
Author: Anthony Agyen

Question:
We are re-evaluating our vendor partnerships for the upcoming fiscal year.
A few suppliers frequently delivered component parts well past their promised
dates during 2012, which disrupted our assembly lines. Which three vendors had
the worst average shipping delays, measured in days, for our manufacturing
schedule?

Answer:
Calculate the average shipping delay for each vendor during 2012 and return
the three vendors with the largest delays.
******************************************************************************************************************/

SELECT TOP (3)
    v.BusinessEntityID,
    v.Name AS VendorName,
    AVG(DATEDIFF(DAY, poh.OrderDate, poh.ShipDate)) AS AverageShippingDays
FROM Purchasing.PurchaseOrderHeader AS poh
INNER JOIN Purchasing.Vendor AS v
    ON poh.VendorID = v.BusinessEntityID
WHERE YEAR(poh.OrderDate) = 2012
  AND poh.ShipDate IS NOT NULL
GROUP BY
    v.BusinessEntityID,
    v.Name
ORDER BY AverageShippingDays DESC;


/*****************************************************************************************************************
Q7
Author: Anthony Agyen

Question:
Which tables within the AdventureWorks database contain a column named
"ProductSubcategoryID"?

Answer:
Search INFORMATION_SCHEMA.COLUMNS for all tables containing the
ProductSubcategoryID column.
******************************************************************************************************************/

SELECT
       TABLE_SCHEMA,
       TABLE_NAME,
       COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'ProductSubcategoryID'
ORDER BY
       TABLE_SCHEMA,
       TABLE_NAME;
GO


/*****************************************************************************************************************
Q8
Author: Domkat Stephen

Question:
For auditing purposes, list all views available in the database and their schemas.
Use INFORMATION_SCHEMA.VIEWS to retrieve view names and associated schema
information.

Answer:
Return every view together with its schema using the
INFORMATION_SCHEMA.VIEWS system view.
******************************************************************************************************************/

SELECT
       TABLE_SCHEMA,
       TABLE_NAME AS ViewName
FROM INFORMATION_SCHEMA.VIEWS
ORDER BY
       TABLE_SCHEMA,
       TABLE_NAME;
GO