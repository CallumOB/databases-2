-- part a
select * from b2_stock where unit_price < unitcostprice;

-- part b 
select stock_code, stock_description from b2_stock where stock_level <= reorder_level;

-- part c 
select customer_name from b2_customer 
left join b2_corder on b2_customer.customer_id = b2_corder.customer_id
where b2_corder.customer_id is null; 

-- part d
select stock_description from b2_corderline 
left join b2_stock on b2_stock.stock_code = b2_corderline.stock_code
where corderno in (
	select corderno from b2_corder 
	left join b2_customer on b2_corder.customer_id = b2_customer.customer_id
	where customer_name = 'John Flaherty');

-- part e 
select customer_id from b2_customer 
join b2_corder using (customer_id)
where corderno in (
	select corderno from b2_corderline
	join b2_corder using (corderno)
	where stock_code = 'A101'
	or stock_code = 'A111');

-- part f 
select customer_id from b2_customer 
join b2_corder using (customer_id)
where corderno in (
	select corderno from b2_corderline
	join b2_corder using (corderno)
	where stock_code in ('A101', 'A111'));

-- part g 
select staff_name from b2_staff
left join b2_corder on b2_corder.staffpaid = b2_staff.staff_no
where corderno in (
select corderno from b2_corder
left join b2_customer using (customer_id)
where customer_name = 'Mary Martin');

-- part h
select staff_name from b2_staff 
left join b2_corder on b2_corder.staffissued = b2_staff.staff_no

