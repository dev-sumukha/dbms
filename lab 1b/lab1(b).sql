-- B) Consider the following database that maintain information about employees & Departments.
-- Employee(empid: int, ename:string, age:int, salary:int, #deptno:int)
-- Department(deptno:int, dname: string, #manager-id: int)
-- i.Create the above tables by properly specifying the primary keys & foreign keys.
-- ii. Enter at least 5 tuples for each relation.
-- iii. Display emp-id & emp name whose salary lies between 10,000 and 50,000.
-- iv. List empname & salary for all the employee working for CS Dept.
-- v. Display empname & deptname for all the managers.

-- creating database
create database employee_details;

-- using database
use employee_details;

-- i.Create the above tables by properly specifying the primary keys & foreign keys.
create table department(deptno int PRIMARY KEY, dname varchar(20), managerid int);
create table employee(empid int PRIMARY KEY, ename varchar(20), age int, salary int, deptno int references department(deptno));

-- displaying dable details
desc employee;
desc department;

-- ii. Enter at least 5 tuples for each relation.
insert into employee values(1, 'Akash', 22, 25000, 101);
insert into employee values(2, 'Arun', 25, 65000, 102);
insert into employee values(3, 'Abhi', 20, 20000, 103),(4, 'Akul', 30, 40000, 104);
insert into employee values(5, 'Anil', 27, 30000, 105);

insert into department values
     (101, 'CS', 201),
     (102, 'Civil', 202),
     (103, 'CS', 203),
     (104, 'Electronics', 204),
     (105, 'Mechanical', 205);

-- displaying the values
select * from employee;
select * from department;

-- iii. Display emp-id & emp name whose salary lies between 10,000 and 50,000.
select empid, ename from employee where salary between 10000 and 50000;

-- iv. List empname & salary for all the employee working for CS Dept.
select ename, salary from employee where deptno in(select deptno from department where dname = 'CS');

-- v. Display empname & deptname for all the managers.
select ename, dname from employee e, department d where e.deptno = d.deptno;
