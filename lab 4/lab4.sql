-- 4. The following tables are maintained by a book dealer.
-- AUTHOR (author-id: int, name: string, city: string, country: string)
-- PUBLISHER (publisher-id: int, name: string, city: string, country: string)
-- CATALOG (book-id: int, title: string, author-id#: int, publisher-id#: int,
-- category-id#: int, year: int, price: int)
-- CATEGORY (category-id: int, description: string)
-- ORDER-DETAILS (order-no: int, #book-id: int, quantity: int)
    -- i. Create the above tables by properly specifying the primary keys and the foreign keys.
    -- ii. Enter at least five tuples for each relation.
    -- iii. Give the details of the authors who have 2 or more books in the catalog and the price of the books is greater than the average price of the books in the catalog.
    -- iv. Find the author of the book, which has maximum sales.
    -- v. Demonstrate how you increase the price of books published by a specific publisher by 10%.

-- creating database
create database book_dealer;

-- using the database
use book_dealer;

-- i. Create the above tables by properly specifying the primary keys and the foreign keys.
create table author(authorid int primary key, name char(10), city char(10), country char(10));
create table publisher(publisherid int primary key, name char(10), city char(10), country char(10));
create table catalog(bookid int primary key, title char(10), authorid int references author(authorid), publisherid int references publisher(publisherid), categoryid int, year int, price int);
create table category(categoryid int PRIMARY KEY, description char(20));
create table order_details(ordno int PRIMARY KEY, bookid int references catalog(bookid), quantity int);

-- ii. Enter at least five tuples for each relation.
insert into author values
    (101, 'p b kottur', 'Bangalore', 'India'),
    (102, 'balguru', 'Delhi', 'India'),
    (103, 'padma r', 'Hyderabad', 'India'),
    (104, 'robert', 'Pans', 'USA'),
    (105, 'wilson', 'Mumbai', 'India');
insert into publisher values
    (1001, 'pearson', 'Pune', 'India'),
    (2002, 'tata', 'Delhi', 'India'),
    (3003, 'pearson', 'Bangalore', 'India'),
    (4004, 'tata', 'Hyderabad', 'India'),
    (5005, 'pearson', 'Gadag', 'India');
insert into category values
    (100, 'networking'),
    (200, 'programming'),
    (300, 'developing'),
    (400, 'security'),
    (500, 'electronics');
insert into catalog values
    (1000, 'java', 101, 1001, 100, 2002, 1590),
    (1001, 'java', 102, 2002, 200, 2003, 2000),
    (1002, 'c++', 103, 3003, 300, 2005, 1500),
    (1003, 'dbms', 104, 4004, 400, 2008, 500),
    (1004, 'os', 105, 5005, 500, 2006, 500);
insert into order_details values
    (1010, 1000, 200),
    (1011, 1001, 300),
    (1012, 1002, 205),
    (1013, 1003, 305),
    (1014, 1004, 500);

-- iii. Give the details of the authors who have 2 or more books in the catalog and the price of the books is greater than the average price of the books in the catalog.
select authorid, name, city, country from author where authorid in (select authorid from catalog where price > (select avg(price) from catalog having count(*) >=2));

-- iv. Find the author of the book, which has maximum sales.
select name from author a, order_details o, catalog c where o.bookid = c.bookid and a.authorid = c.authorid and o.quantity = (select max(quantity) from order_details);

-- v. Demonstrate how you increase the price of books published by a specific publisher by 10%.
update catalog set price = 1.1 * price where publisherid in (select publisherid from publisher where name = 'pearson');
select * from publisher;
select * from catalog;

