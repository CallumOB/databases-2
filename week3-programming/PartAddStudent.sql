create or replace FUNCTION ADDSTUDENT(
    p_name student.st_name%type)
    returns INTEGER AS 
$$
DECLARE
      v_st_id INTEGER;
BEGIN
        insert into student (st_name)
values (p_name) returning st_id into v_st_id;
	return 	v_st_id;
END;
$$  LANGUAGE plpgsql
