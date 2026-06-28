create table emp_test (
id integer,
name varchar,
salary integer,
location varchar
)

Insert into emp_test values(1,'manish',10000,'india')
Insert into emp_test(id,name,location) values(2,'mani','india')
Insert into emp_test values(3,'rahul',20000,'usa'),(4,'megha',30000,'india'),(5,'abc',40000,'india')

--- Fetch the data 
select * from emp_test
select id,name from emp_test

-- Filter 
select * from emp_test where location ='india'
select * from emp_test where location ='usa'


-- sort the data 
select * from emp_test order by salary desc
select * from emp_test order by salary asc
select * from emp_test order by name asc


--- null filter 

select * from emp_test where salary is null
select * from emp_test where salary is not null

-- group by 

select sum(salary),location from emp_test
group by location 

-----------------------------------------------------------------
delete vs drop vs truncate 

-- delete - Removes specific rows from a table
-- Truncate - Removes ALL rows from a table (fast)
-- Drop - Deletes entire table (data + structure)

select * from emp_test

delete from emp_test where id=3

--- Truncate 
Truncate table emp_test

-- drop 

drop table emp_test


-----------------------------------------------------------------------
-- JOINING 

CREATE OR REPLACE TABLE employees (
    name STRING,
    emp_id INT,
    dept_id INT,
    salary INT
);
INSERT INTO employees (name, emp_id, dept_id, salary) VALUES
('Alice', 1, 1, 50000),
('Bob', 2, 2, 45000),
('Charlie', 3, 5, 48000),
('David', 4, 4, 52000);

CREATE OR REPLACE TABLE departments (
    department_id INT,
    department_name STRING
);

INSERT INTO departments (department_id, department_name) VALUES
(1, 'Human Resources'),
(2, 'Finance'),
(3, 'IT');

select * from employees

select * from departments

---inner join 

select * from employees inner join departments on employees.dept_id = departments.department_id

--- left join 
select * from employees left join departments on employees.dept_id = departments.department_id

-- right join 

select * from employees right join departments on employees.dept_id = departments.department_id

-- full join 
select * from employees full join departments on employees.dept_id = departments.department_id


create table emp_test(
emp_id int,
emp_name varchar,
salary int
)


CREATE or replace FILE FORMAT custom_csv_format
TYPE = CSV
FIELD_DELIMITER = ','
SKIP_HEADER = 1
DATE_FORMAT = 'DD/MM/YYYY';