create or replace procedure make_matches(
	p_tkey tournament.tkey%type, 
	p_round match.tround%type, 
	nomatches integer)
	LANGUAGE plpgsql
AS $$
 begin
	 for i in 1..nomatches loop
		 insert into match (tkey, tround, matchno) 
		 values (p_tkey, p_round, i);
	 END loop;
 end; 
$$;
 