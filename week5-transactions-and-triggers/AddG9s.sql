/*Add role and schema for user "G99999999"*/

DROP ROLE IF EXISTS "G99999999"; 
CREATE ROLE  "G99999999" WITH LOGIN PASSWORD 'G99999999'; 
CREATE SCHEMA  "G99999999" AUTHORIZATION "G99999999";
