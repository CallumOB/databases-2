/*select * from crisp_type;
select * from consumer;
select * from has_eaten;
*/
/*                    MAKE THE VIEWS                            */
--Make a view showing the join

create or replace view crispeater as 
  SELECT CN_NAME, CP_NAME FROM consumer
  JOIN has_eaten USING (CONSUMERID)
  JOIN crisp_type USING (CRISPKEY);
select * from crispeater;

/*          ONLY        */

--Consumers who only ate Cheese and Onion
select CN_NAME from crispeater where CP_NAME = 'Cheese and Onion'
except
select CN_NAME from crispeater where CP_NAME <> 'Cheese and Onion';

/*          ONE BUT NOT ANOTHER        */
--Consumers who  ate 'Cheese and Onion' but not ''Buffalo'-

select CN_NAME from crispeater where CP_NAME = 'Cheese and Onion'
except
select CN_NAME from crispeater where CP_NAME = 'Buffalo';

/*          BOTH        */

--Consumers who  ate 'Cheese and Onion' and 'Buffalo'
select CN_NAME from crispeater where CP_NAME = 'Cheese and Onion'
INTERSECT
select CN_NAME from crispeater where CP_NAME = 'Buffalo';

/*          EITHER        */

--Consumers who  ate 'Cheese and Onion' or 'Buffalo'
select CN_NAME from crispeater where CP_NAME = 'Cheese and Onion'
UNION
select CN_NAME from crispeater where CP_NAME = 'Buffalo';


/*         EITHER, BUT NOT BOTH (XOR)            */


--Consumers who  ate 'Cheese and Onion' or  'Buffalo' but not both.
select CN_NAME from crispeater where CP_NAME = 'Cheese and Onion'
UNION
select CN_NAME from crispeater where CP_NAME = 'Buffalo'
except
(select CN_NAME from crispeater where CP_NAME = 'Cheese and Onion'
INTERSECT
select CN_NAME from crispeater where CP_NAME = 'Buffalo');



/*          DIVIDE        */
/*Return a list of occurrences of A that are related to ALL 
occurrences of B*/

--Consumers who  ate all types of crisps.
select CN_NAME from consumer A where not exists
  (select * from crisp_type B where not exists 
  (select * from has_eaten X
    where X.consumerid = A.consumerid
  and X.crispkey = B.crispkey));

