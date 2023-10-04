-- function to add a student and return the student ID
CREATE OR replace FUNCTION ADDSTUDENT(
	p_sname student.st_name%type)
	RETURNS integer AS 
$$
DECLARE 
	v_st_id INTEGER;
BEGIN 
	INSERT INTO student (st_name) 
	VALUES (p_sname) returning st_id INTO v_st_id;
	RETURN v_st_id;
END;
$$ LANGUAGE plpgsql


-- function to add a new subject and return the subject id
CREATE OR replace FUNCTION ADDSUBJECT(
	p_sbname subject.sb_name%type)
	RETURNS integer AS 
$$ 
DECLARE
	v_sb_id integer;
BEGIN
	INSERT INTO subject (sb_name)
	VALUES (p_sbname) returning sb_id INTO v_sb_id;
	RETURN v_sb_id;
END;
$$ LANGUAGE plpgsql


-- function to add a new achievement given the student and subject name 
CREATE OR replace FUNCTION ADDACHIEVEMENT(
	p_stid student.st_id%TYPE,
	p_sbid subject.sb_id%type)
BEGIN	
	INSERT INTO achievement (st_id, sb_id)
	VALUES (p_stid, p_sbid);
END;
$$ LANGUAGE plpgsql

