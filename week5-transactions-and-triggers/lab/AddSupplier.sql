
CREATE OR REPLACE FUNCTION addSupplier(
p_sname character varying, p_ph character)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
DECLARE
      v_supplier_id integer;
begin
        insert into "C21306503".sh_supplier (sname, sph)
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

create table supplier_log (
	supplier_id integer,
	supplier_name varchar(80),
	suplier_phone varchar(15),
	username varchar(80),
	currentdate date
);

create or replace function audit_supplier() returns trigger as $audit_supplier$
declare 
	uname varchar(80);
	cdate date;
begin
	select user into strict uname;
	select now() into strict cdate;
	insert into "C21306503".supplier_log values (new.supplier_id, new.sname, new.sph, uname, cdate);
	return new;
end;
$audit_supplier$ language plpgsql;

create or replace trigger audit_supplier before insert or update on "C21306503".sh_supplier
	for each row execute function audit_supplier();

grant ALL on schema "C21306503" to "D22126511";
grant execute on function addSupplier to "D22126511";
grant select on "C21306503".sh_supplier to "D22126511";
grant insert on "C21306503".sh_supplier to "D22126511";
grant update on "C21306503".sh_supplier to "D22126511";
grant select on "C21306503".supplier_log to "D22126511";
grant insert on "C21306503".supplier_log to "D22126511";
grant update on "C21306503".supplier_log to "D22126511";

grant usage, select on sequence sh_supplier_supplier_id_seq to "D22126511";

select * from sh_supplier;
select addSupplier('Lidl', 12345::character);

select * from supplier_log;
