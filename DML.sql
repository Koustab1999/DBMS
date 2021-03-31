# DML Operations(insert,update and delete)

-- The INSERT statement allows you to insert one or more rows into a table. The following illustrates the syntax of the INSERT statement:

 

/*INSERT INTO table(c1,c2,...)
VALUES (v1,v2,...); */

DESCRIBE departments;


-- Insert demo without specifying column names
INSERT INTO departments VALUES(100,'Technical');

INSERT INTO departments VALUES(101,'Sales');

INSERT INTO departments VALUES(102,'HR');

INSERT INTO departments VALUES(103,'Production');

INSERT INTO departments VALUES(104,'Travel');

SELECT * FROM departments;

-- Insert demo specifying column names

DESCRIBE user;

INSERT INTO user(NAME,email) VALUES ('Mike','mike@training.com');

INSERT INTO user(NAME,email) VALUES ('John','john@training.com');

SELECT * FROM user;

DESCRIBE employees;

INSERT INTO employees(first_name,last_name,dob,STATUS,description,dept_id)
VALUES('Koustab','Jaiswal','1999-02-21',1,'Testing JDBC',100);

 -- INSERT INTO employees(first_name,last_name,dob,STATUS,description,dept_id) 
INSERT INTO EMPLOYEES VALUES('Raj','ga','1985-06-16',2,'sales',101); -- ?

-- INSERT INTO employees(first_name,last_name,dob,STATUS,description,dept_id) 
INSERT INTO employees VALUES('Rahul','J','1999-04-21',3,'HR',102);

SELECT * FROM employees;

DESC people;



INSERT INTO people(last_name,mid_name,first_name,birthday,phone,gender,salary)
VALUES ('Jaiswal','Java','James','1999-02-21',9876543,'Male',12000);

-- salary check constraint
INSERT INTO people(last_name,mid_name,first_name,birthday,phone,gender,salary)
INSERT INTO people VALUES ('koustab','Java','James','1999-02-21',9876543,'Male',500);  -- ?

-- unique constraint
INSERT INTO people(last_name,mid_name,first_name,birthday,phone,gender,salary)
INSERT INTO people VALUES ('prasad','Java','James','1999-02-21',9876543,'Male',15000);  -- ?

SELECT * FROM people;
DESCRIBE people;

# Change value of Auto Increment

SELECT * FROM user;

ALTER TABLE user AUTO_INCREMENT=100;

INSERT INTO user(NAME,email) VALUES('Sita','sita@training.com');

SELECT * FROM user;

#Update Statement

/*
The UPDATE statement updates data in a table. 
It allows you to change the values in one or more columns of a single row or multiple rows.

 syntax of the UPDATE statement:

UPDATE  table_name 
SET 
    column_name1 = expr1,
    column_name2 = expr2,
    ...
[WHERE
    condition];
*/

UPDATE user SET email = 'john123@training.com'
WHERE id =2;

SELECT * FROM user;

UPDATE user SET NAME = 'Mary Keneth', email = 'mary123@training.com'
WHERE id =3;

USE classicmodels;

-- -- Using MySQL UPDATE to update rows returned by a SELECT statement example

SELECT customername,salesRepEmployeeNumber
FROM customers
WHERE salesRepEmployeeNumber IS NULL;

SELECT employeeNumber FROM employees
WHERE jobtitle = 'Sales Rep' ORDER BY RAND()
LIMIT 1;

UPDATE customers SET salesRepEmployeeNumber = (SELECT employeeNumber FROM employees
WHERE jobtitle = 'Sales Rep' ORDER BY RAND()
LIMIT 1) WHERE salesRepEmployeeNumber IS NULL;

SELECT customername,salesRepEmployeeNumber
FROM customers
WHERE salesRepEmployeeNumber IS NULL;

SELECT * FROM employees;

# DELETE statement
 /*To delete data from a table, you use the MySQL DELETE statement. 
 syntax of the DELETE statement:

 

DELETE FROM table_name
WHERE condition;  */

SELECT * FROM employees_copy;

DELETE FROM employees_copy WHERE officeCODE =4

DELETE FROM employees_copy; -- caution don't execute

-- Using limit in delete

SELECT * FROM customers_copy;

DELETE FROM customers_copy ORDER BY customerName LIMIT 10;

DELETE FROM customers_copy WHERE country = 'France' 
ORDER BY creditLimit LIMIT 5;

# Truncate
/* MYSQL TRUNCATE statement removes the complete data without 
removing its structure.

 

The TRUNCATE TABLE statement is used when you want to delete the complete data from a 
table without removing the table structure. */

TRUNCATE TABLE employees_copy;
TRUNCATE TABLE customers_copy;

SELECT * FROM customers_copy;

SELECT * FROM employees_copy;

