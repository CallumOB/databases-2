-- all staff members who sold notepads
select staff_name from "sample".sh_staff
join "sample".sh_sale using (staff_no)
join "sample".sh_stock using (stock_code)
where stock_name = 'Notepad';

-- staff members who sold nothing
select staff_name from "sample".sh_staff
left join "sample".sh_sale using (staff_no)
where "sample".sh_staff.staff_no not in 
(select staff_no from "sample".sh_sale);

-- staff members that sold both notepads and chocolate bars
create or replace view notepad_choc as
(select staff_name from "sample".sh_staff
join "sample".sh_sale using (staff_no)
join "sample".sh_stock using (stock_code)
where stock_name = 'Notepad')
intersect
(select staff_name from "sample".sh_staff
join "sample".sh_sale using (staff_no)
join "sample".sh_stock using (stock_code)
where stock_name = 'Chocolate bar');

select * from notepad_choc;

-- staff members that sold either notepads or choc bars
(select staff_name from "sample".sh_staff
join "sample".sh_sale using (staff_no)
join "sample".sh_stock using (stock_code)
where stock_name = 'Notepad')
union
(select staff_name from "sample".sh_staff
join "sample".sh_sale using (staff_no)
join "sample".sh_stock using (stock_code)
where stock_name = 'Chocolate bar')
except 
select * from notepad_choc;


-- staff members who sold only notepads 
select staff_name from "sample".sh_staff
join "sample".sh_sale using (staff_no)
join "sample".sh_stock using (stock_code)
where stock_name = 'Notepad'
except 
select staff_name from "sample".sh_staff
join "sample".sh_sale using (staff_no)
join "sample".sh_stock using (stock_code)
where stock_name <> 'Notepad';

-- staff members who sold all stock
select staff_name
from "sample".sh_staff 
join "sample".sh_sale using (staff_no)
join "sample".sh_stock using (stock_code)
group by staff_name
having (count(staff_name) >= (
select count(stock_code) from "sample".sh_stock));


-- staff members that have sold all stock supplied by Cadbury
create or replace view cadburystock as 
select stock_code from "sample".sh_stock
left join "sample".sh_supplier using (supplier_id)
where sname = 'Cadbury';

select staff_name
from "sample".sh_staff 
join "sample".sh_sale using (staff_no)
join "sample".sh_stock using (stock_code)
join "sample".sh_supplier using (supplier_id)
where sname = 'Cadbury'
group by staff_name
having (count(stock_code) >= 
(select count(stock_code) from cadburystock));

-- question 8
select stock_name, catdescription, cast(price as money) "Cost", 
cast(avg(price) over
(partition by catdescription) as money)
from "sample".sh_stock 
join "sample".sh_category using (catcode)
group by stock_name, catdescription, price;

-- question 9
select stock_name, catdescription, lag(price, 1) over 
(partition by catdescription
order by price) as previous_price,
price - lag(price, 1) over (
partition by catdescription order by price) as difference
from "sample".sh_stock 
join "sample".sh_category using (catcode);




