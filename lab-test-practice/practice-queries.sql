-- question 1: books not recommended for any module
-- find a book that is not in the recommends table. uses not exists
create or replace view booksnotrec as 
select title from "book".book 
where not exists 
(select * from "book".recommends 
where "book".recommends.isbn = "book".book.isbn);

select * from booksnotrec;

-- q2: books recommended for more than one module
-- find a book where the number of times it appears in recommends > 1
create or replace view mult_recs as 
select title from "book".book b
join "book".recommends r using (isbn)
group by b.title
having count(r.isbn) > 1;

select * from mult_recs;

-- q3: books recommended for all modules
-- find a book where its occurrences in recommends = the number of modules
-- works since a module cannot recommend a book twice 
create or replace view rec_all as 
select title from "book".book b 
join "book".recommends r using (isbn)
group by b.title 
having count(r.isbn) = 
(select count(mod_code) from "book".module);

select * from rec_all;

-- q4: authors that have written books recommended for more than one module
-- uses the view from q2, find authors that have written books in that view
create or replace view author_rec_all as
select distinct author_name from "book".author a
left join "book".authors ar using (author_id)
left join "book".book b using (isbn)
left join "book".recommends r using (isbn)
where b.title in (select * from mult_recs);

select * from author_rec_all;

-- q5: modules that only recommend the book 'SQL Cookbook'
-- find modules that recommend the book SQL cookbook
-- without the except, this will just return any module that recommends SQL Cookbook
-- but we only want SQL cookbook, so we do without where title != SQL Cookbook
-- this way it returns modules that exclusively recommend SQL Cookbook 
create or replace view cookbook_only as 
select mod_name from "book".module m 
join "book".recommends r using (mod_code) 
join "book".book b using (isbn) 
where r.isbn = (select isbn from "book".book
	where title = 'SQL Cookbook')
except 
select mod_name from "book".module m 
join "book".recommends r using (mod_code)
join "book".book b using (isbn)
where r.isbn <> (select isbn from "book".book
	where title = 'SQL Cookbook');

select * from cookbook_only;

-- q6: authors recommended for databases 1 or machine learning but not both
-- think of this as an XOR. we want authors recommended for db1 XOR ML.
-- think of logic gates: find DB1 OR ML
create or replace view authors_db1_or_ml as 
select author_name from "book".author a 
join "book".authors ar using (author_id)
join "book".book b using (isbn)
join "book".recommends r using (isbn)
join "book".module m using (mod_code)
where 
r.mod_code = (select mod_code from "book".module
	where mod_name = 'Databases 1')
union 
select author_name from "book".author a 
join "book".authors ar using (author_id)
join "book".book b using (isbn)
join "book".recommends r using (isbn)
join "book".module m using (mod_code)
where 
r.mod_code = (select mod_code from "book".module
	where mod_name = 'Machine Learning');

-- then find DB1 AND ML
create or replace view authors_db1_and_ml as
select author_name from "book".author a 
join "book".authors ar using (author_id)
join "book".book b using (isbn)
join "book".recommends r using (isbn)
join "book".module m using (mod_code)
where 
r.mod_code = (select mod_code from "book".module
	where mod_name = 'Databases 1')
intersect 
select author_name from "book".author a 
join "book".authors ar using (author_id)
join "book".book b using (isbn)
join "book".recommends r using (isbn)
join "book".module m using (mod_code)
where 
r.mod_code = (select mod_code from "book".module
	where mod_name = 'Machine Learning');

-- lastly, find (DB1 OR ML) minus (DB1 AND ML), which gives us XOR 
create or replace view authors_db1_xor_ml as
select * from authors_db1_or_ml 
except
select * from authors_db1_and_ml;

select * from authors_db1_xor_ml;


-- q7: mod_name of the module that recommends most books
-- create a view where the rank is given an alias
create or replace view most_rec as 
select mod_name, rank() over (
	order by count(r.isbn) desc) as recommendation_rank
from "book".module m
left join "book".recommends r using (mod_code)
group by m.mod_code, m.mod_name;    
       
-- then query the view where the rank = 1 using the alias 
select mod_name from most_rec
where recommendation_rank = 1;

-- q8: title, year, author's name and order by year of publication from that author
-- just uses a simple partition by and order by, self explanatory
create or replace view author_ordered as
select title, yearofpublication, author_name, rank() over (
	partition by author_name
	order by yearofpublication) as year_pub
from "book".book b 
join "book".authors ar using (isbn)
join "book".author a using (author_id)
order by author_name asc;

select * from author_ordered;
