CREATE OR REPLACE FUNCTION "G99999999".addcustorder(p_cust_id integer, p_staff_no integer)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
DECLARE
      v_orderno INTEGER;
BEGIN
  if customer_exists(p_cust_id) and staff_exists(p_staff_no)then
  	INSERT INTO B2_CORDER (ORDER_DATE, CUSTOMER_ID, STAFFPAID)
  	VALUES (current_date,p_cust_id,p_staff_no) RETURNING CORDERNO into v_orderno;
	return v_orderno;
  else return(0);
  end if;
END;
$function$
;
