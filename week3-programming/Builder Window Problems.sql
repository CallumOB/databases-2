-- BUILDER GROUP BY AND PARTITION BY
/* 1. Select each supplier name and the stock_code and stock_description of each stock item 
 that supplier supplies.
*/
select supplier_name, stock_code, stock_description, unit_price 
from b2_supplier join b2_stock using (supplier_id);
-- Complete the following queries:
/* 2. Select each supplier name and average unit_price of stock that supplier supplies.*/
select supplier_name, cast(avg (unit_price) as money) price
from b2_supplier join b2_stock using (supplier_id)
group by supplier_name;

/* 3. Select each supplier name and average unit_price of stock that supplier supplies,
 * where the supplier's average is > 100.*/
select supplier_name, cast(avg (unit_price) as money) price
from b2_supplier join b2_stock using (supplier_id)
group by (supplier_name)
having avg(unit_price) > 100;

/* 4. Select each supplier name, the stock_code, stock_description, unit_price and 
 * average unit_price for that supplier for each stock item that supplier supplies.
*/
select supplier_name, stock_code, stock_description, unit_price,
avg(unit_price) over (partition by supplier_name)
from b2_supplier join b2_stock using (supplier_id);

/*5. Select each supplier name, the stock_code, stock_description, unit_price and 
 * rank of that price for that supplier for each stock item that supplier supplies.
*/
select supplier_name, stock_code, stock_description, unit_price,
rank() over (partition by supplier_name order by unit_price ASC)
from b2_supplier join b2_stock using (supplier_id)
;

/*6. Show  the supplier_name, stock_code, stock_description, unit_price, difference 
between this price and the price of the previous item in the list from this supplier. 
Hint: Use lag()  to compare item prices from a supplier, going from lowest to highest. 
*/
SELECT supplier_name, stock_code, stock_description, unit_price,
lag(unit_price, 1) over (partition by unit_price) as "Price of Current - Previous item"
FROM b2_supplier join b2_stock using (supplier_id);

