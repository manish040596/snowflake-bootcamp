--permananent
create table emp_manish (id int)

show tables

create Temp table emp_manish_1 (id int)

--transient table 

create Transient table emp_manish_2 (id int)

-- external table 
create external table emp_manish_2 (id int)
location 

-- ice berg table 

create iceberg table emp_manish_3 (id int)

-- hybrid 

create hybrid table emp_manish_4 (id int PRIMARY KEY)

list @~

create stage emp_stg


desc stage emp_stg

list @emp_stg

