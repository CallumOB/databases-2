CREATE OR REPLACE FUNCTION "builder".addstudent(p_name character varying)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
DECLARE
      v_st_id INTEGER;
BEGIN
        insert into "builder".student (st_name)
values (p_name) returning st_id into v_st_id;
	return 	v_st_id;
END;
$function$
;