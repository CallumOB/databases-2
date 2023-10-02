create or replace FUNCTION ADDSTUDENT(
    p_name ...%type)
    returns INTEGER AS 
$$
DECLARE
      v_st_id INTEGER;
BEGIN
        insert into student (st_name)
values (p_name) returning ...
END;
$$  LANGUAGE plpgsql
