/*1.  List names of suppliers who supply no stock items */
select supplier_name from b2_supplier 
left join 
b2_stock 
using (supplier_id)
where stock_code is null;

/* 2.  Get the name of any customer who bought the item with stock description 'Phillips screwdriver'.*/
select customer_name from b2_customer 
join b2_corder using (customer_id)
join b2_corderline using (corderno)
join b2_stock using (stock_code)
-- put join attribute / condition in here
where stock_description = 'Phillips screwdriver';

/* 3. Get names of all staff members and the corderno for any orders they issued. */
select staff_name, corderno from b2_staff 
-- put join in here
left join b2_corder on b2_staff.staff_no = b2_corder.staffissued 
-- put join attribute / condition in here

/* 4. List the supplier_id and  supplier_name  for all supplier orders that were not delivered.*/
select supplier_id, supplier_name from b2_supplier  
-- put join path in here
join b2_sorder using (supplier_id) 
-- put join attribute and / or final condition in here
where delivereddate is null
