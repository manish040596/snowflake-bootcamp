show tables;

select * from customers

insert into customers values(106,'qbs','djf')

delete from customers where customer_id=105

update customers set customer_name='mani' where customer_id=104

---stream

create or replace stream cust_stream 
on table customers;

select * from cust_stream

-- standard stream 

-- append only 

INSERT 

CREATE STREAM EMP_STREAM
ON TABLE EMPLOYEE
APPEND_ONLY = TRUE;
