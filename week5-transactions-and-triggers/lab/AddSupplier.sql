
CREATE OR REPLACE FUNCTION addsupplier(
p_sname character varying, p_ph character)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
DECLARE
      v_supplier_id integer;
begin
        insert into "CornerShop".sh_supplier (sname, sph)
		values (p_sname, p_ph) returning supplier_id into v_supplier_id;
        RETURN v_supplier_id;
exception
when others then
        RAISE INFO 'Error Name:%',SQLERRM;
        RAISE INFO 'Error State:%', SQLSTATE;
        return null;
END;
$function$
;