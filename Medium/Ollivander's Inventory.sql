-- MSSQL

WITH S AS ( 
    SELECT W.id, WP.age, W.coins_needed, W.power,RANK() OVER (PARTITION BY WP.age, W.power ORDER BY W.coins_needed) AS RN FROM Wands W JOIN Wands_Property WP 
    ON W.CODE = WP.CODE 
    WHERE IS_EVIL=0
)

SELECT id, age, coins_needed, power FROM S Where RN = 1
ORDER BY power desc, age desc
