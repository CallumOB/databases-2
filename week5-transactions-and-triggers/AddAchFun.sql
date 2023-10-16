create or replace procedure ADDapr(
    p_st_name STUDENT.ST_name%type,
    p_sb_name SUBJECT.SB_name%type)
	AS 
$$
DECLARE
      v_SB_id INTEGER;
      v_St_id INTEGER;
begin
	select ST_ID into V_ST_ID from student where st_name = p_st_name;
	select SB_ID into V_SB_ID from subject where sb_name = p_sb_name;
    insert into achievement(st_id, sb_id)
	values (v_st_id, v_sb_id);
exception
when others then
	raise info 'Error Name: %', sqlerrm;
	raise info 'Error State: %', sqlstate;
END;
$$  LANGUAGE plpgsql

call ADDapr('Lisa', 'Geography');