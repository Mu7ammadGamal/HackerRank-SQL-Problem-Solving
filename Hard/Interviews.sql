-- MSSQL

select t1.cid, t1.hid, t1.n, t1.s1, t1.s2, t2.s3, t2.s4 from
(select ct.contest_id cid, ct.hacker_id hid, ct.name n, sum(s.total_submissions) s1, sum(s.total_accepted_submissions) s2
from Contests ct 
    join Colleges cg on ct.contest_id = cg.contest_id
    join Challenges ch on ch.college_id = cg.college_id
    join Submission_Stats s on ch.challenge_id = s.challenge_id
    group by ct.contest_id, ct.hacker_id, ct.name) t1 
join 
(select ct.contest_id cid, ct.hacker_id hid, ct.name n,sum(v.total_views) s3, sum(v.total_unique_views) s4
    from Contests ct 
    join Colleges cg on ct.contest_id = cg.contest_id
    join Challenges ch on ch.college_id = cg.college_id
    join View_Stats v on ch.challenge_id = v.challenge_id
    group by ct.contest_id, ct.hacker_id, ct.name) t2
on t1.hid = t2.hid
order by t1.cid
