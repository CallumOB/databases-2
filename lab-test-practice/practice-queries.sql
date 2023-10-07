-- question 1: books not recommended for any module
create or replace view booksnotrec as 
select title from "book".book 
where not exists 
(select * from "book".recommends 
where "book".recommends.isbn = "book".book.isbn);

select * from booksnotrec;

-- q2: books recommended for more than one module
create or replace view mult_recs as 
select title from "book".book b
join "book".recommends r using (isbn)
group by b.title
having count(r.isbn) > 1;

select * from mult_recs;

-- q3: books recommended for all modules
create or replace view rec_all as 
select title from "book".book b 
join "book".recommends r using (isbn)
group by b.title 
having count(r.isbn) = 
(select count(mod_code) from "book".module);

select * from rec_all;

-- q4: authors that have written books recommended for more than one module
create or replace view author_rec_all as
select distinct author_name from "book".author a
left join "book".authors ar using (author_id)
left join "book".book b using (isbn)
left join "book".recommends r using (isbn)
where b.title in (select * from rec_all);

select * from author_rec_all;

-- q5: modules that only recommend the book 'SQL Cookbook'
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

create or replace view authors_db1_xor_ml as
select * from authors_db1_or_ml 
except
select * from authors_db1_and_ml;

select * from authors_db1_xor_ml;


