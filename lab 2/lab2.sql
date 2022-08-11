-- 2. Consider the following schema for Order Database:
-- SALESMAN (Salesman_id, Name, City, Commission)
-- CUSTOMER (Customer_id, Cust_Name, City, Grade,Salesman_id)
-- ORDERS (Ord_No, Purchase_Amt, Ord_Date, #Customer_id, Salesman_id)
    -- Write SQL queries to
    -- i. Count the customers with grades above Bangalore’s average.
    -- ii. Find the name and numbers of all salesmen who had more than one customer.
    -- iii. List all salesmen and indicate those who have and don’t have customers in their cities (Use UNION operation.)
    -- iv. Create a view that finds the salesman who has the customer with the highest order of a day.
    -- v. Demonstrate the DELETE operation by removing salesman with id 1000. All his orders must also be deleted.

-- creating database
create database order_details;

-- using database
use order_details;

-- creating the tables
create table salesman(salesmanid int PRIMARY KEY, name var
create table customer(customerid int PRIMARY KEY, cust_name varchar(10), city varchar(10), grade int, salesmanid int references salesman(salesmanid));
create table orders(ordno int, purchase_amt int, ord_date date, customerid int references customer(customerid), salesmanid int references salesman(salesmanid));

-- inserting the values into the table
insert into salesman values
    (01, 'John', 'Bangalore', 1500),
    (02, 'Johnny', 'Hubli', 2000),
    (03, 'Janardhan', 'Dharwad', 2500),
    (04, 'Akash', 'Bangalore', 1800),
    (05, 'Anand', 'Gadag', 3000);
insert into customer values
    (11, 'Akshay', 'Bangalore', 10, 01),
    (22, 'Nagaraj', 'Mysore', 20, 02),
    (33, 'Rahul', 'Mangalore', 10, 03),
    (44, 'Swati', 'Hubli', 30, 04),
    (55, 'Yash', 'Gadag', 20, 05);
insert into orders values
    (111, 13000, '2022-01-01', 11, 1),
    (222, 15000, '2022-02-02', 22, 2),
    (333, 20000, '2022-03-03', 33, 3),
    (444, 25000, '2022-04-04', 44, 4),
    (555, 30000, '2022-05-05', 55, 5);

-- displaying the values from the tables
select * from salesman;
select * from customer;
select * from orders;

-- i. Count the customers with grades above Bangalore’s average.
select count(*) from customer where grade > (select avg(grade) from customer where city = 'Bangalore');

-- ii. Find the name and numbers of all salesmen who had more than one customer.
select name, salesmanid from salesman s where 1>(select count(*) from customer where salesmanid = s.salesmanid);

-- iii. List all salesmen and indicate those who have and don’t have customers in their cities (Use UNION operation.)
select s.salesmanid, name, cust_name, commission from salesman s, customer c where s.city = c.city UNION(select salesmanid, name, 'NO MATCH', commission from salesman where NOT city = any(select city from customer)) order by 2 desc;

-- iv. Create a view that finds the salesman who has the customer with the highest order of a day.
create view elitsalesman1 as select o.ord_date, s.salesmanid, s.name from salesman s, orders o where s.salesmanid = o.salesmanid and purchase_amt = (select max(purchase_amt) from orders c where c.ord_date = o.ord_date);
select * from elitsalesman1;

-- v. Demonstrate the DELETE operation by removing salesman with id 1000. All his orders must also be deleted.
