select lt_actor.aname from lt_actor
where not exists
(select * from lt_movie
where exists
(select * from lt_actsin
where lt_actsin.ainitial = lt_actor.ainitial
and lt_actsin.minityear = lt_movie.minityear));
select aname from lt_actor where ainitial not in (
select ainitial  from lt_actsin);

explain analyse select lt_actor.aname from lt_actor
where not exists
(select * from lt_movie
where exists
(select * from lt_actsin
where lt_actsin.ainitial = lt_actor.ainitial
and lt_actsin.minityear = lt_movie.minityear));
select aname from lt_actor where ainitial not in (
select ainitial  from lt_actsin);

select aname from lt_actor la2
where not exists (select * from lt_actsin la
where la.ainitial = la2.ainitial);

explain analyse select aname from lt_actor la2
where not exists (select * from lt_actsin la
where la.ainitial = la2.ainitial);

select aname from lt_actor 
where ainitial not in (select ainitial from lt_actsin);

-- planning time 0.047 ms, execution time 0.033 ms
explain analyse select aname from lt_actor 
where ainitial not in (select ainitial from lt_actsin);

select aname from lt_movie lm
right join lt_actsin l using(minityear)
right join lt_actor la using(ainitial)
where mname is null;

explain analyse 
select aname from lt_movie lm
right join lt_actsin l using(minityear)
right join lt_actor la using(ainitial)
where mname is null;


select sname from lt_student
left join lt_joined using(sno)
left join lt_club using(clubid)
where cname is null
union
select sname from lt_student
left join lt_joined using(sno)
left join lt_club using(clubid)
group by sname
having count(cname) = 0;

explain analyze
select sname from lt_student
left join lt_joined using(sno)
left join lt_club using(clubid)
where cname is null
union
select sname from lt_student
left join lt_joined using(sno)
left join lt_club using(clubid)
group by sname
having count(cname) = 0;

select lt_student.sname from lt_student
full join lt_joined using(sno)
full join lt_club using(clubid)
group by lt_student.sname
having count(lt_club.cname) < 1;

explain analyze select lt_student.sname from lt_student
full join lt_joined using(sno)
full join lt_club using(clubid)
group by lt_student.sname
having count(lt_club.cname) < 1;

select l_name from musiclover
where l_name not in (select l_name from musicdownload join musiclover using (l_id))
group by l_name;

explain analyze 
select l_name from musiclover
where l_name not in (select l_name from musicdownload join musiclover using (l_id))
group by l_name;

select l_name from musiclover m
left join musicdownload m2 using (l_id)
group by l_name
having count(t_id) = 0;

explain analyze select l_name from musiclover m
left join musicdownload m2 using (l_id)
group by l_name
having count(t_id) = 0;

select l_name from musiclover where l_id not in 
(select l_id from musicdownload);

explain analyze select l_name from musiclover where l_id not in 
(select l_id from musicdownload);