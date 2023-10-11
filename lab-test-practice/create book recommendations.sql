drop table recommends cascade;
drop table authors cascade;
drop table author cascade;
drop table book cascade;
drop table module cascade;
CREATE TABLE author (
    author_id          SERIAL primary key,
    author_name        VARCHAR(80)
     NOT NULL,
    author_yearofbirth numeric(4)
);
insert into author (author_name) values ('Brian MacNamee');
insert into author (author_name) values ('John D. Kelleher');
insert into author (author_name) values ('Brendan Tierney');
insert into author (author_name) values ('Arup Nanda');
insert into author (author_name) values ('Anthony Molinaro');
insert into author (author_name) values ('Robert de GraaF');

CREATE TABLE book (
    isbn              VARCHAR(10) primary KEY,
    title 			  varchar(80) not null,
    yearofpublication numeric(4),
    price             numeric(8, 2) NOT NULL
);
insert into book(isbn, yearofpublication, title, price) values ('ABC1',2005, 'SQL Cookbook',28);
insert into book(isbn, yearofpublication,title, price) values ('ABC2',2018, 'Data Science',15);
insert into book(isbn, yearofpublication,title, price) values ('ABC3', 2016, 'Real World SQL',35);
insert into BOOK(isbn, yearofpublication,title, price)  VALUEs ('ABC4',2019,'Deep Learning',15);
insert into BOOK(isbn, yearofpublication,title, price)  VALUEs ('ABC5',2015, 'Machine Learning',15);

CREATE TABLE authors (
    isbn        VARCHAR(10) not null references BOOK,
    author_id INTEGER NOT null references AUTHOR,
    primary key (isbn, author_id)
);
insert into authors values ('ABC1',5);
insert into authors values ('ABC1',6);
insert into authors values ('ABC2',3);
insert into authors values ('ABC2',2);
insert into authors values ('ABC3',3);
insert into authors values ('ABC4',2);
insert into authors values ('ABC5',2);
insert into authors values ('ABC5',1);


CREATE TABLE module (
    mod_code varchar(8) primary KEY,
    mod_name varchar(30) NOT NULL,
    ects     INTEGER
);

insert into module values ('CMPU2007', 'Databases 1', 5);
insert into module values ('CMPU3010', 'Databases 2', 5);
insert into module values ('CMPU3051', 'Intro to AI',5);
insert into module values ('CMPU4003', 'Advanced Databases', 5);
insert into module values ('DATA9110', 'Working with Data', 5);
insert into module values ('CMPU4011', 'Machine Learning', 5);


CREATE TABLE recommends (
    mod_code varchar(8) NOT null references MODULE,
    isbn       varchar(10) NOT null references BOOK,
    primary key (MOD_CODE, ISBN)
);
insert into recommends values ('CMPU2007','ABC1');
insert into recommends values ('CMPU2007','ABC3');
insert into recommends values ('CMPU3010','ABC1');
insert into recommends values ('CMPU3010','ABC3');
insert into recommends values ('CMPU3010','ABC2');
insert into recommends values ('CMPU3051','ABC1');
insert into recommends values ('CMPU4003','ABC1');
insert into recommends values ('CMPU4003','ABC2');
insert into recommends values ('CMPU4003','ABC3');
insert into recommends values ('CMPU4011','ABC5');
insert into recommends values ('CMPU4011','ABC1');
insert into recommends values ('DATA9110','ABC1');
grant usage on schema "book" to public;
grant select on table recommends to public;
grant select on table author to public;
grant select on table authors to public;
grant select on table book to public;
grant select on table module to public;
commit;
