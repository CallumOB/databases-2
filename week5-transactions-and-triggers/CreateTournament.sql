drop table match;
drop table player;
drop table tournament;
create table tournament (
TKey char(8) primary key,
TName varchar(40) not null,
Sponsor varchar(70),
TType varchar(10));
insert into tournament values ('Ashe','The Ashe Cup','Arthur Ashe','Knockout');

create table player (
playerid serial primary key,
pname varchar(40) not null,
pdateofbirth date);
insert into player (pname) values ('Mary');
insert into player (pname) values ('John');
insert into player (pname) values ('Anne');
insert into player (pname) values ('Ivan');
insert into player (pname) values ('Mona');
insert into player (pname) values ('Maud');
insert into player (pname) values ('Cait');
insert into player (pname) values ('Bert');
insert into player (pname) values ('Connie');
insert into player (pname) values ('Declan');
insert into player (pname) values ('Eddie');
insert into player (pname) values ('Fern');
insert into player (pname) values ('Gina');
insert into player (pname) values ('Harry');
insert into player (pname) values ('Kelly');
insert into player (pname) values ('Laura');

create table match (
TKey char(8) not null references tournament,
TRound integer not null,
MatchNo integer not null,
Player_1 integer references player(playerid),
player_2 integer references player(playerid),
score_1 integer,
score_2 integer,
primary key (Tkey, TRound, MatchNo));
