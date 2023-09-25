/* Display the customer order number (corderno), stock_code and cost (unit_price * quantityrequired) 
 * of every order line (corderline) on every customer order (corder).*/

select corderno, stock_code, 
-- calculate cost here
from b2_corder join b2_corderline using (corderno)
join b2_stock using (stock_code)
--add any clauses required here
;

/* Display the customer order number (corderno) and total cost (unit_price * quantityrequired) 
 * of  every customer order (corder).*/
select corderno, 
-- calculate total cost here
from b2_corder join b2_corderline using (corderno)
join b2_stock using (stock_code)
--add any clauses required here
;

/* Display the customer order number (corderno) and total cost (unit_price * quantityrequired) 
 * of  every customer order that costs more than €2,000.*/
select corderno, 
-- calculate total cost here
from b2_corder join b2_corderline using (corderno)
join b2_stock using (stock_code)
--add any clauses required here
;