
/*
drop view staffsold;
drop view b;*/
DROP TABLE sh_SALE cascade;
DROP TABLE sh_stock cascade;
drop TABLE sh_category cascade;
DROP TABLE sh_STAFF cascade;
DROP TABLE sh_supplier cascade;

CREATE TABLE sh_supplier (
  supplier_id serial primary key,
  sname VARCHAR(40) not null,
  sph char(13)
);

CREATE TABLE sh_category (
catcode varchar(10) PRIMARY KEY,
catdescription varchar(50) NOT NULL,
storageconditions varchar(255));

CREATE TABLE sh_stock (
       stock_code      CHAR(8) primary key,
       supplier_id integer references sh_supplier,
       stock_name      VARCHAR(20),
       QuantityInstock INTEGER,
       price           NUMERIC(5,2),
       catcode varchar(10) NOT NULL REFERENCES sh_category
);

CREATE TABLE sh_Staff (
       Staff_no   serial PRIMARY KEY,
       Staff_name VARCHAR(25) NULL
);

CREATE TABLE sh_sale (
       stock_code CHAR(8) REFERENCES sh_stock,
       Staff_no   integer REFERENCES sh_STAFF,
       SaleDate   DATE,
       quantity   INTEGER,
       PRIMARY KEY (stock_code, Staff_no, SaleDate)
);
BEGIN TRANSACTION;
INSERT INTO sh_supplier (sname, sph) VALUES 
('Cadbury','5555555'),
('Tayto','5555555'),
('Eason','5555555'),
('Tesco','5555555');

INSERT INTO sh_category VALUES 
('Stationery','Stationery items','Standard shelving'),
('Food NP', 'Non-perishable food','Standard Shelves'),
('DailyNews','Daily newspapers','Front of shop shelves'),
('Fridge','Refrigerated goods','Display fridge'),
('Food P', 'Perishable food not chilled','By register');


INSERT INTO sh_stock VALUES ('A11111',3,'Notepad',20,2.95,'Stationery'),
 ('A11112',3,'Blue biro',40,.55,'Stationery'),
('A11113',3,'Red biro',40,.55,'Stationery'),
('A11114',3,'Ring binder',10,2.60,'Stationery'),
('A11115',3,'Eraser',40,.30,'Stationery'),
('B11111',1,'Snack bar',24,.80,'Food NP'),
('B11112',1,'Chocolate bar',24,.80,'Fridge'),
('E11111',2,'Cheese+onion crisps',24,.70,'Food NP'),
 ('D11111',4,'Chicken sandwich',24,2.95,'Fridge'),
('F11111',4,'Mineral drink',12,2.20,'Fridge'),
('C11111',3,'Newspaper',12,1, 'DailyNews'),
 ('C11112',3,'Weekly Magazine',12,1, 'DailyNews'),
 ('U11112',3,'Weekly Magazine',12,1, 'DailyNews');
--
--select * from sh_supplier natural join sh_stock;


insert into sh_stock(stock_code, stock_name, quantityinstock, price, catcode)
values ('U11111','Home-made bread', 10, 2.00,'Food P' );

INSERT INTO sh_STAFF (staff_name) VALUES 
('Damian'),
 ('Bing'),
 ('Fred'),
 ('Deirdre'),
 ('Richard'),
 ('Patricia'),
 ('June'),
 ('Mark');
--




INSERT INTO sh_sale(stock_code, staff_no, saledate,quantity) VALUES 
('A11111',1,current_date-8,1),
('A11111',1,current_date-7,1),
('A11111',1,current_date-6,3),
('B11111',1,current_date-5,2),
('B11111',2,current_date-5,2),
('B11112',1,current_date-5,2),
('B11112',2,current_date-5,2),
('C11111',1,current_date-4,1),
('C11112',1,current_date-7,1),
('A11111',3,current_date-3,1),
('A11114',3,current_date-2,1),
('E11111',3,current_date-1,1),
('F11111',3,current_date-9,1),
('D11111',3,current_date-10,2),
('A11111',5,current_date-12,1),
('A11112',1,current_date-4,1),
('A11113',1,current_date-4,1),
('A11114',1,current_date-4,1),
('A11115',1,current_date-4,1),
('D11111',1,current_date-4,1),
('E11111',1,current_date-4,1),
('F11111',1,current_date-4,1);
commit;

select * from sh_category full join sh_stock using (catcode)
full join sh_supplier using (supplier_id)
full join sh_sale using (stock_code)
full join sh_staff using (staff_no);