/*****************************************************************************************************************
NAME:    EC_IT143_W5.2_MyFC_GA.sql

PURPOSE:
Answer four stakeholder questions for the MyFC community dataset.

MODIFICATION LOG:
Ver      Date         Author    Description
-----   ----------   --------   ------------------------------------------------
1.0     07/25/2026   GA         Initial version.

RUNTIME:
< 1 second

NOTES:
This script answers four business questions using the MyFC dataset.
******************************************************************************************************************/

USE MyFC;
GO


/*****************************************************************************************************************
Question 1
Author: Gabriel Ayeh

Question:
Which teams have the largest number of registered players?
******************************************************************************************************************/

SELECT
    T.t_code AS Team_Code,
    COUNT(P.pl_id) AS Number_of_Players
FROM dbo.tblPlayerDim AS P
INNER JOIN dbo.tblTeamDim AS T
    ON P.t_id = T.t_id
GROUP BY
    T.t_code
ORDER BY
    Number_of_Players DESC;
GO

/*****************************************************************************************************************
Question 2
Author: Gabriel Ayeh

Question:
How many players are assigned to each playing position?
******************************************************************************************************************/

SELECT
    POS.p_name AS Position_Name,
    COUNT(P.pl_id) AS Number_of_Players
FROM dbo.tblPlayerDim AS P
INNER JOIN dbo.tblPositionDim AS POS
    ON P.p_id = POS.p_id
GROUP BY
    POS.p_name
ORDER BY
    Number_of_Players DESC;
GO

/*****************************************************************************************************************
Question 3
Author: Gabriel Ayeh

Question:
Which players belong to each team and what positions do they play?
******************************************************************************************************************/
--This query joins three tables and displays each player’s team, position, and jersey number.
SELECT
    P.pl_id AS Player_ID,
    P.f_name + ' ' + P.l_name AS Player_Name,
    T.t_code AS Team_Code,
    POS.p_name AS Position_Name,
    P.pl_num AS Jersey_Number
FROM dbo.tblPlayerDim AS P
INNER JOIN dbo.tblTeamDim AS T
    ON P.t_id = T.t_id
INNER JOIN dbo.tblPositionDim AS POS
    ON P.p_id = POS.p_id
ORDER BY
    T.t_code,
    Player_Name;
GO

/*****************************************************************************************************************
Question 4
Author: Victor Chukwudi

Question:
Which teams have players wearing the same jersey number more than once? I would like to see the team name,
player names, and jersey numbers to identify duplicate jersey numbers within each team.
******************************************************************************************************************/

SELECT
    T.t_code AS Team_Code,
    P.pl_num AS Jersey_Number,
    P.f_name + ' ' + P.l_name AS Player_Name
FROM dbo.tblPlayerDim AS P
INNER JOIN dbo.tblTeamDim AS T
    ON P.t_id = T.t_id
WHERE EXISTS
(
    SELECT 1
    FROM dbo.tblPlayerDim AS P2
    WHERE P2.t_id = P.t_id
      AND P2.pl_num = P.pl_num
    GROUP BY P2.t_id, P2.pl_num
    HAVING COUNT(*) > 1
)
ORDER BY
    Team_Code,
    Jersey_Number,
    Player_Name;
GO