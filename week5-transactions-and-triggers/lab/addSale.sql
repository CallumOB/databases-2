-- B: addSale() procedure
create or replace procedure addSale(
	p_stock_code sh_stock.stock_code%type,
	p_staff_no sh_staff.staff_no%type,
	p_quantity sh_stock.quantityinstock%type)
	as 
$$
declare 
	v_quantityinstock INTEGER;
	v_num_staff INTEGER;
begin
	select count(staff_no) into v_num_staff from sh_staff where staff_no = p_staff_no;
	if v_num_staff = 0 then raise exception 'No such staff member'; end if;
	select quantityinstock into v_quantityinstock from sh_stock where stock_code = p_stock_code;
	if v_quantityinstock < p_quantity then raise exception 'Not enough stock'; end if;
	insert into sh_sale (stock_code, staff_no, SaleDate, quantity)
	values (p_stock_code, p_staff_no, now(), p_quantity);
	update sh_stock set quantityinstock = quantityinstock - p_quantity where stock_code = p_stock_code;
exception
when others then 
	raise info 'Error Name: %', sqlerrm;
	raise info 'Error State: %', sqlstate;
END;
$$ language plpgsql

-- testing procedure

select * from sh_stock order by stock_code asc;
select * from sh_staff;
select * from sh_sale order by saledate desc;


call addSale('A11111', 1, 10);

-- will fail for stock quantity
call addSale('A11111', 1, 100);

-- will fail for staff_no
call addSale('A11111', 100, 1);





