-- MSSQL

WITH CTE AS
(select Start_Date, End_Date , DATEADD(DAY, -ROW_NUMBER() over (order by Start_Date), Start_Date) DIFF
from Projects)
SELECT MIN(Start_Date), MAX(End_Date)
FROM CTE
GROUP BY DIFF
ORDER BY COUNT(*) , MIN(Start_Date) 
