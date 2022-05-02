DROP TABLE IF EXISTS CUSTOMERS;

CREATE TABLE CUSTOMERS
(
    customer_id   serial PRIMARY KEY,
    customer_name VARCHAR(50) UNIQUE NOT NULL,
    added_time    TIMESTAMP DEFAULT NULL
);

INSERT INTO CUSTOMERS(customer_id, customer_name, added_time) VALUES (1, 'Oleh', current_timestamp);
INSERT INTO CUSTOMERS(customer_id, customer_name, added_time) VALUES (2, 'Olha', current_timestamp);
INSERT INTO CUSTOMERS(customer_id, customer_name, added_time) VALUES (3, 'David', current_timestamp);
INSERT INTO CUSTOMERS(customer_id, customer_name, added_time) VALUES (4, 'Nina', current_timestamp);

SELECT * FROM CUSTOMERS;