--MSSQL
------------------------------------------------

WITH cte AS (
SELECT n, 1 AS d FROM bst where p is null
	UNION ALL
SELECT bst.n, cte.d + 1 AS d FROM cte JOIN bst ON cte.n = bst.p
)
SELECT n, 
CASE 
	WHEN d = 1 THEN 'Root' 
	WHEN d = (SELECT max(d) FROM cte) THEN 'Leaf' 
	ELSE 'Inner' 
END AS d 
FROM cte order by n

------------------------------------------------
--EXPLAIN:
--idea is to assign level no. to each node 
--then min level is root, and max level is leaf 
--else is inner
