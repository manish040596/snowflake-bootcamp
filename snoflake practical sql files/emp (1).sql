create table emp_test1 (id int , name varchar(28),salary int , country varchar(28));

insert into emp_test1 values(1,'manish',10000,'india')
insert into emp_test1 values(2,'RAHUL',10000,'INDIA')
insert into emp_test1 values(3,'HEMA',10000,'IND')
insert into emp_test1 values(4,'mani',10000,'india')
insert into emp_test1 values(4,'mani',10000,null)
insert into emp_test1 values(4,'mani',10000,'')
insert into emp_test1 values(3,'HEMA',-10000,'IND')


SELECT * FROM emp_test1


CREATE OR REPLACE TABLE EMPLOYEE_TEST2
(
    EMP_ID NUMBER,
    EMP_NAME STRING,
    DEPARTMENT STRING,
    SALARY NUMBER,
    LOAD_TIMESTAMP TIMESTAMP
);

INSERT INTO EMPLOYEE_TEST2
VALUES
(1,'John','IT',5000,'2026-07-03 09:00:00'),
(2,'David','HR',6000,'2026-07-03 09:00:00'),
(3,'Mike','Sales',7000,'2026-07-03 09:00:00'),
(4,'Alex','Finance',8000,'2026-07-03 09:00:00');

INSERT INTO EMPLOYEE_TEST2
VALUES
(1,'John','IT',5000,'2026-07-05 07:30:00'),
(2,'David','HR',6000,'2026-07-05 07:30:00'),
(4,'Alex','Finance',8000,'2026-07-05 07:30:00');

SELECT * FROM EMPLOYEE_TEST2

-----------snapshot 


CREATE OR REPLACE TABLE emp_test2
(
EMP_ID NUMBER,
EMP_NAME STRING,
DEPARTMENT STRING,
SALARY NUMBER,
UPDATED_AT TIMESTAMP
);


INSERT INTO emp_test2 VALUES
(101,'John','IT',50000,CURRENT_TIMESTAMP()),
(102,'David','HR',60000,CURRENT_TIMESTAMP()),
(103,'Mike','Sales',70000,CURRENT_TIMESTAMP());


select * from emp_test2;

create schema snapshot


--- snapshot timestamp strategy 


UPDATE emp_test2
SET SALARY=75000,
UPDATED_AT=CURRENT_TIMESTAMP()
WHERE EMP_ID=101;


select * from snapshot.employee_snapshot


--- snapshot -- check strategy 


CREATE OR REPLACE TABLE EMPLOYEE_CHECK
(
    EMP_ID NUMBER,
    EMP_NAME STRING,
    DEPARTMENT STRING,
    SALARY NUMBER
);

INSERT INTO EMPLOYEE_CHECK
VALUES
(101,'John','IT',50000),
(102,'David','HR',60000),
(103,'Mike','Sales',70000);

select * from EMPLOYEE_CHECK

select * from snapshot.employee_check_snapshot


UPDATE EMPLOYEE_CHECK
SET SALARY = 65000
WHERE EMP_ID = 101;



----incremental load 


CREATE OR REPLACE TABLE EMPLOYEE_INCREMENTAL
(
EMP_ID NUMBER,
EMP_NAME STRING,
DEPARTMENT STRING,
SALARY NUMBER,
UPDATED_AT TIMESTAMP
);

INSERT INTO EMPLOYEE_INCREMENTAL
VALUES
(101,'John','IT',50000,'2026-07-01 09:00:00'),
(102,'David','HR',60000,'2026-07-01 09:00:00'),
(103,'Mike','Sales',70000,'2026-07-01 09:00:00');

INSERT INTO EMPLOYEE_INCREMENTAL
VALUES
(104,'Mike','Sales',70000,'2026-07-02 09:00:00');


select * from EMPLOYEE_INCREMENTAL

select * from dim_EMPLOYEE_INCREMENTAL



CREATE OR REPLACE TABLE AUDIT_LOG
(
LOAD_TIME TIMESTAMP,
MODEL_NAME STRING,
STATUS STRING
);
