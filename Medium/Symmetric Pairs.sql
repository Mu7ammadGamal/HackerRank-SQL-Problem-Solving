-- MSSQL

-- row_number() for not joining pair itself in which x1 = y1 already
with cte as (select x,y,row_number() over(order by x) as rn from functions)
select distinct f1.x,f1.y 
from cte f1 
join cte f2 on f1.x = f2.y and f1.y = f2.x and f1.rn != f2.rn
where f1.x <= f1.y 
order by 1
