/*create table stock_log (
  stock_code varchar(8),
  unit_price numeric(8,2),
  unitcostprice numeric(8,2),
  stock_level integer,
  username varchar(80),
  currentdate date); 
);*/
CREATE or replace FUNCTION audit_stock() RETURNS trigger AS $audit_stock$
DECLARE
  uname varchar(80);
  cdate date;
BEGIN
	select user into strict uname; 
    select now() into strict cdate;
    insert into stock_log values (new.stock_code, new.unit_price, new.unitcostprice, new.stock_level, uname, cdate);
	return new;
END;
$audit_stock$ LANGUAGE plpgsql;

CREATE or replace TRIGGER audit_stock BEFORE INSERT OR UPDATE ON b2_stock
    FOR EACH ROW EXECUTE FUNCTION audit_stock();
  
