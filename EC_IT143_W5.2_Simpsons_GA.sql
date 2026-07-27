/*****************************************************************************************************************
NAME:    EC_IT143_W5.2_Simpsons_GA.sql

PURPOSE:
Answer four stakeholder questions for the Simpsons community dataset.

MODIFICATION LOG:
Ver      Date         Author    Description
-----   ----------   --------   ------------------------------------------------
1.0     07/27/2026   GA         Initial version.

RUNTIME:
< 1 second

NOTES:
This script answers four questions using the Simpsons database.
Question 4 was written by another student.
******************************************************************************************************************/

USE Simpsons;
GO

/*****************************************************************************************************************
Question 1
Author: Gabriel Ayeh

Question:
How many members are assigned to each department? I would like to see each department and its total number of
members so staffing levels can be compared.
******************************************************************************************************************/

SELECT
    Department,
    COUNT(*) AS Number_of_Members
FROM dbo.Family_Data
GROUP BY
    Department
ORDER BY
    Number_of_Members DESC,
    Department;
GO

/*****************************************************************************************************************
Question 2
Author: Gabriel Ayeh

Question:
Which members work in each department, and who manages them? I would like to see member names, job titles,
department names, managers, and employment status to review the organizational structure.
******************************************************************************************************************/

SELECT
    Member_ID,
    Name AS Member_Name,
    Job_Title,
    Department,
    Manager,
    Status
FROM dbo.Family_Data
ORDER BY
    Department,
    Manager,
    Name;
GO

/*****************************************************************************************************************
Question 3
Author: Gabriel Ayeh

Question:
What is the average age of members in each department? I would like to compare department names and average
member ages to support workforce and succession planning.
******************************************************************************************************************/

SELECT
    Department,
    COUNT(*) AS Members_With_Birth_Dates,
    CAST
    (
        AVG
        (
            CAST
            (
                DATEDIFF(YEAR, Birth_Date, GETDATE())
                -
                CASE
                    WHEN DATEADD
                    (
                        YEAR,
                        DATEDIFF(YEAR, Birth_Date, GETDATE()),
                        Birth_Date
                    ) > CAST(GETDATE() AS date)
                    THEN 1
                    ELSE 0
                END
                AS decimal(10,2)
            )
        )
        AS decimal(10,2)
    ) AS Average_Age
FROM dbo.Family_Data
WHERE
    Birth_Date IS NOT NULL
GROUP BY
    Department
ORDER BY
    Average_Age DESC;
GO

/*****************************************************************************************************************
Question 4
Author: Victor Chukwudi

Question:
Which category appears most frequently in the data? I would like to see the category name together with the total
number of records to better understand the overall distribution of transactions.
******************************************************************************************************************/

SELECT
    Category,
    COUNT(*) AS Total_Records
FROM dbo.Planet_Express
GROUP BY
    Category
ORDER BY
    Total_Records DESC,
    Category;
GO