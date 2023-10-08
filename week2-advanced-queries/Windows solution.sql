select * from products join product_groups using (group_id);

SELECT group_name, AVG (price)
FROM products
JOIN product_groups USING (group_id)
GROUP BY group_name;

-- To get the average price per group, add the appropriate partition clause
SELECT product_name, price, group_name, 
avg(price)  over (partition by group_name)
-- Add partition clause here
FROM products
JOIN  product_groups USING (group_id);

select product_name, group_name, price, row_number () over (
	partition by group_name
	order by price) ThisRank
from products 
join product_groups using (group_id);
