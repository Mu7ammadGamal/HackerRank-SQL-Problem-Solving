-- MSSQL

-- CTE1 to get total number of unique hackers who made at least 1 submission each day
-- CTE2 to get the hacker who made maximum number of submissions each day

WITH CTE1 AS (
  select 
    sd sd, 
    count(*) uh 
  from 
    (
      select 
        submission_date sd, 
        hacker_id hid, 
        (
          select 
            count(distinct s2.submission_date) 
          from 
            submissions s2 
          where 
            s2.submission_date <= s1.submission_date 
            and s2.hacker_id = s1.hacker_id
        ) n 
      from 
        submissions s1 
      group by 
        submission_date, 
        hacker_id
    ) as t 
  where 
    n >= datediff(day, '2016-03-01', sd)+ 1 
  group by 
    sd
), 
CTE2 AS (
  select 
    sd, 
    hid 
  from 
    (
      select 
        sd sd, 
        hid hid, 
        ns, 
        DENSE_RANK() over (
          partition by sd 
          order by 
            ns desc, 
            hid asc
        ) r 
      from 
        (
          select 
            submission_date sd, 
            hacker_id hid, 
            (
              select 
                count(s2.hacker_id) 
              from 
                submissions s2 
              where 
                s2.submission_date = s1.submission_date 
                and s2.hacker_id = s1.hacker_id
            ) ns 
          from 
            submissions s1 
          group by 
            submission_date, 
            hacker_id
        ) as t
    ) t2 
  where 
    r = 1
) 
select 
  CTE1.sd, 
  CTE1.uh, 
  CTE2.hid, 
  h.name 
from 
  CTE1 
  join CTE2 on CTE1.sd = CTE2.sd 
  join hackers h on h.hacker_id = CTE2.hid
