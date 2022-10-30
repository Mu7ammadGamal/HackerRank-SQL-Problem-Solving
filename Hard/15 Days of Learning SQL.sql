-- MSSQL

select 
  t1.sd, 
  t1.uh, 
  t2.hid, 
  h.name 
from 
  (
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
  ) t1 
  join (
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
  ) t2 on t1.sd = t2.sd 
  join hackers h on h.hacker_id = t2.hid
