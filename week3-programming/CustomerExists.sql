CREATE OR REPLACE FUNCTION customer_exists(p_custid integer)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
DECLARE
	  cname b2_customer.customer_name%type;
BEGIN
  SELECT customer_name into strict cname FROM B2_CUSTOMER WHERE CUSTOMER_ID = p_custid;
   return true;
exception 
WHEN NO_DATA_FOUND then
	RAISE EXCEPTION 'customer id not found : %', p_custid  using hint = 'Check customer id again';
	return false;
END;
$function$
;

