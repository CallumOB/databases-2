-- Q1: name of actors who acted in the movie The Post but not Toy Story
/* In this query I find the actors who acted in 'The Post', 
 * excluding those who have acted in Toy Story.
 * I use like '%Toy Story%' to find any movie with 'Toy Story' in the name,
 * since there is more than one.
 */
create or replace view post_not_toy_story as
select aname from lt_actor a 
left join lt_actsin ai using (ainitial)
where ai.minityear = (select minityear from lt_movie m
	where mname = 'The Post')
except 
select aname from lt_actor a 
left join lt_actsin ai using (ainitial)
where ai.minityear in (select minityear from lt_movie m
	where mname LIKE '%Toy Story%');
		
select * from post_not_toy_story;

-- q2: Actors who acted in all movies
/* I use count() here to find actors with a number of appearances matching
 * the number of movies in the lt_movies table.
 */
create or replace view all_movies as
select aname from lt_actor a
left join lt_actsin ai using (ainitial)
join lt_movie m using (minityear)
group by aname
having count(ai.ainitial) = (select count(minityear) from lt_movie);

select * from all_movies;

-- q3: actors who only appear in the movie 'The Post'
/* Here I find actors who have appeared in 'The Post'.
 * This will also return actors who have appeared in other movies too,
 * so I exclude actors who have appeared in movies that are not 'The Post'.
 */
create or replace view post_only as 
select aname from lt_actor a 
left join lt_actsin ai using (ainitial)
where ai.minityear = (select minityear from lt_movie m
	where mname = 'The Post')
except 
select aname from lt_actor a 
left join lt_actsin ai using (ainitial)
where ai.minityear <> (select minityear from lt_movie m
	where mname = 'The Post');

select * from post_only;

-- q4: List names of actors who have appeared in > 2 movies
/* Here I find actors where their number of appearances in lt_actsin is > 2. */
create or replace view two_movies as 
select aname from lt_actor a 
join lt_actsin ai using (ainitial)
group by aname 
having count (ai.ainitial) > 2;

select * from two_movies;

-- q5: actor's name and year of each movie, with order of roles played
/* This query uses the rank() function, where the rank is assigned
 * based on the actor's name in order of the movie year.
 */
create or replace view movie_order as 
select mname, aname, myear, rank() over (
	partition by aname
	order by myear) as order_played
from lt_actor a 
join lt_actsin ai using (ainitial)
join lt_movie m using (minityear);

select * from movie_order;
