CREATE OR REPLACE TABLE ORDERS
(
    ORDER_ID NUMBER,
    CUSTOMER_ID NUMBER,
    PRODUCT STRING,
    AMOUNT NUMBER,
    ORDER_DATE DATE
);

create stage order_Stg_new;
list @order_Stg_new

COPY INTO ORDERS FROM @order_Stg_new file_format=(type='csv',skip_header=1)


select * from ORDERS

list @order_Stg_new


COPY INTO ORDERS FROM @order_Stg_new file_format=(type='csv',skip_header=1)

