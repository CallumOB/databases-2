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
...;
/* 3. Select each supplier name and average unit_price of stock that supplier supplies,
 * where the supplier's average is > 100.*/
select supplier_name, cast(avg (unit_price) as money) price
from b2_supplier join b2_stock using (supplier_id)
...

/* 4. Select each supplier name, the stock_code, stock_description, unit_price and 
 * average unit_price for that supplier for each stock item that supplier supplies.
*/
select supplier_name, stock_code, stock_description, unit_price,
...
from b2_supplier join b2_stock using (supplier_id)
...;
/*5. Select each supplier name, the stock_code, stock_description, unit_price and 
 * rank of that price for that supplier for each stock item that supplier supplies.
*/
select supplier_name, stock_code, stock_description, unit_price,
...
from b2_supplier join b2_stock using (supplier_id)
...;

/*6. Show  the supplier_name, stock_code, stock_description, unit_price, difference 
between this price and the price of the previous item in the list from this supplier. 
Hint: Use lag()  to compare item prices from a supplier, going from lowest to highest. 
*/
SELECT supplier_name, stock_code, stock_description, unit_price,
lag(... "Price of Current - Previous item"
FROM b2_supplier join b2_stock using (supplier_id);

