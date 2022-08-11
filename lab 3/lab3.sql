-- 3. Consider the Insurances database given below. The primary keys are underlined the data types are specified.
-- PERSON (DRIVER-ID#: string, name: string, address: string)
-- CAR (Regno: string, model: string, year: int)
-- ACCIDENT (report-number: int, date: date, location: string)
-- OWNS (#driver-id: string, #Regno: string)
-- PARTICIPATED (#driver-id: string, #Regno: string, #report-number: int, Damage amount: int)
    -- i. Create the above tables by property specifying the primary keys and the foreign keys.
    -- ii. Enter atleast five tables for each relation.
    -- iii. Demonstrate how you
        -- a. Update the damage amount for the car with a specific Regno in the accident with report number 12 to 25000.
        -- b. Add a new accident to the database.
    -- iv. Find the total number of people who owned cars that were involved in accidents in 2002.
    -- v. Find the total number of accidents in which cars belonging to a specific model were involved.

-- creating database 
create database insurance;

-- using database 
use insurance;

-- i. Create the above tables by property specifying the primary keys and the foreign keys.
create table person(driverId char(10) PRIMARY KEY, name char(10), address char(10));
create table car(regno char(10) PRIMARY KEY, model char(10), year int);
create table accident(reportno int, date date, location char(10));
create table owns(driverId char(10), FOREIGN KEY (driverId) references person(driverId), regno char(10), FOREIGN KEY (regno) references car(regno));
create table participated(driverId char(10) references person(driverId), regno char(10) references car(regno), reportno int references accident(reportno), damageAmt int);

-- ii. Enter atleast five tables for each relation.
insert into person values
    ('a20','Rohita','Vidyanagar'),
    ('a21','Rahul','GokulRoad'),
    ('a22','Rani','Hosur'),
    ('a23','Ravi','Keshwapur'),
    ('a24','Rohit','MGRoad');
insert into car values
    ('ka20','Santro',2000),
    ('ka21','Benz',2001),
    ('ka22','Ferari',2002),
    ('ka23','Hatiz',2003),
    ('ka24','Swift',2004);
insert into accident values
    (11,'2001-01-01','Gadag'),
    (12,'2002-02-02','Hubli'),
    (13,'2003-03-03','Bombay'),
    (14,'2004-04-04','Delhi'),
    (15,'2005-05-05','Goa');
insert into owns values
    ('a20','ka20'),
    ('a21','ka21'),
    ('a22','ka22'),
    ('a23','ka23'),
    ('a24','ka24');
insert into participated values
    ('a20','ka20',11,1000),
    ('a21','ka21',12,2000),
    ('a22','ka22',13,3000),
    ('a23','ka23',14,4000),
    ('a24','ka24',15,5000);

-- displaying the values
select * from person;
select * from car;
select * from accident;
select * from owns;
select * from participated;

-- iii. Demonstrate how you
-- a. Update the damage amount for the car with a specific Regno in the accident with report number 12 to 25000.
update participated set damageAmt = 25000 where regno = 'ka21' and reportno = 12;
select * from participated;

-- b. Add a new accident to the database.
insert into accident values(18, '2008-08-05', 'Dharwad');
select * from accident;

-- iv. Find the total number of people who owned cars that were involved in accidents in 2002.
select count(driverId) from participated p, accident a where p.reportno = a.reportno AND date BETWEEN '2002-01-01' AND '2002-12-31';

-- v. Find the total number of accidents in which cars belonging to a specific model were involved.
select count(reportno) from participated p,car c where p.regno = c.regno


