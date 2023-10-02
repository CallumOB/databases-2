create or replace FUNCTION ADDCUSTOMER(
    p_cname b2_customer.customer_name%type,
    p_caddr b2_customer.customer_address%type default NULL)
    returns INTEGER AS 
$$
DECLARE
      v_custid INTEGER;
BEGIN
        insert into b2_customer (customer_name, customer_address)
values (p_cname, p_caddr) returning customer_id into v_custid;
        RETURN v_custid;
END;
$$  LANGUAGE plpgsql

