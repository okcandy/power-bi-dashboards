/* 

Analysis of Olympic games data 

*/

--Overview of the dataset
SELECT TOP (1000) [ID]
		,[Name]
		,[Sex]
		,[Age]
		,[Height]
		,[Weight]
		,[NOC]
		,[Games]
		,[City]
		,[Sport]
		,[Event]
		,[Medal]
FROM OlympicDatabase..athlete_events$
ORDER BY 1;

SELECT
         [ID]
        ,[Name] AS 'Competitor Name' 
        ,CASE WHEN SEX = 'M' THEN 'Male' ELSE 'Female' END AS Sex
        ,[Age]
				,CASE	WHEN [Age] < 18 THEN 'Under 18'
							WHEN [Age] BETWEEN 18 AND 25 THEN '18-25'
							WHEN [Age] BETWEEN 25 AND 30 THEN '25-30'
							WHEN [Age] > 30 THEN 'Over 30'
				END AS [Age Grouping]
        ,[Height]
        ,[Weight]
        ,[NOC] AS 'Nation Code' 
        ,LEFT(Games, CHARINDEX(' ', Games) - 1) AS 'Year' -- Split column to retrieve year
        ,RIGHT(Games,CHARINDEX(' ', REVERSE(Games))-1) AS 'Season' -- Split column to isolate Season
        ,[Games]
        ,[Sport]
        ,[Event]
        ,CASE WHEN Medal = 'NA' THEN 'Not Registered' ELSE Medal END AS Medal -- Null values replaced
FROM OlympicDatabase..athlete_events$
WHERE RIGHT(Games,CHARINDEX(' ', REVERSE(Games))-1) = 'Summer' -- Filter summer olympics only
ORDER BY ID;

