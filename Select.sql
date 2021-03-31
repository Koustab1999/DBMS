SHOW DATABASES;

USE CLASSICMODELS;

SHOW TABLES;

-- Select Statements
-- SELECT select_list;
-- FROM table_name;

SELECT * FROM customers;  /*SELECTION*/
SELECT * FROM employees;
SELECT * FROM orderdetails WHERE quantityOrdered >=50 AND priceEach > 100;

SELECT lastname FROM employees; /*projection -- select specific coloum*/

SELECT lastname,firstname,jobtitle FROM employees; 

/*MySQL WHERE clause

The WHERE clause allows you to specify a search condition for the rows returned by a query.
#Syntax :
SELECT 
select_list 
FROM table_name 
WHERE search_condition;*/

SELECT lastname,firstname,jobtitle FROM employees WHERE jobtitle = 'Sales Rep';

/*The search_condition is a combination of one or more predicates using the 
logical operator  AND ,OR AND NOT.*/

/*example uses the WHERE clause to find employees whose job titles are 
Sales Rep and office codes are 1*/


SELECT lastname,firstname,jobtitle,officeCode FROM employees WHERE 
jobtitle = 'Sales Rep' AND officeCode=1;

/*query finds employees whose job title is Sales Rep or employees who locate the office with office code 1:*/

SELECT lastname,firstname,jobtitle,officeCode FROM employees WHERE 
jobtitle = 'Sales Rep' OR officeCode=1; /* ANY ONE CONDITION MUST ME TRUE


    
/*The BETWEEN operator returns TRUE if a value is in a range of values:

-- Syntax: expression BETWEEN low AND high*/

SELECT lastname,firstname,jobtitle,officeCode FROM employees WHERE 
officeCode BETWEEN 1 AND 3 ORDER BY officeCode; 

-- query to list the orders done in first quater of 2004

SELECT * FROM orders WHERE shippedDate BETWEEN '2004-01-01' AND '2004-03-31' -- ?


# MySQL WHERE with the LIKE operator

 /* The LIKE operator evaluates to TRUE if a value matches a specified pattern.
 To form a pattern, you use % and _ wildcards.
 The % wildcard matches any string of zero or more characters
 while the _ wildcard matches any single character. */

 -- query finds employees whose last names end with the string 'son':
 
 
SELECT lastname,firstname,jobtitle FROM employees WHERE lastname LIKE '%son';


SELECT lastname,firstname,jobtitle FROM employees WHERE lastname LIKE 'p%';

SELECT lastname,firstname,jobtitle FROM employees WHERE lastname LIKE '_array';

SELECT lastname,firstname,jobtitle FROM employees WHERE firstname LIKE 'A%' OR  lastname LIKE'S%'; -- ?


SELECT lastname,firstname,jobtitle FROM employees WHERE firstname NOT LIKE 'A%' AND lastname LIKE 'k%';


#MySQL WHERE clause with the IN operator

 

-- The IN operator returns TRUE if a value matches any value in a list.
-- Syntax
-- value IN (value1, value2,...) 


SELECT lastname,firstname,jobtitle,officeCode FROM employees WHERE 
officeCode IN(1,5,7) ORDER BY officeCode; -- this will reduct multipal OR statements

SELECT * FROM customers WHERE contactLastName IN ('Young','Smith');

#MYSQL WHERE clause with the IS NUll operator 
-- NULL -> Absence of Data or Data is missing

/* To check if a value is NULL or not, you use the IS NULL operator, 
not the equal operator (=). The IS NULL operator returns TRUE if a value is NULL.

Syntax: 
value IS NULL  */ 

SELECT lastname,firstname,reportsTo FROM employees WHERE reportsTo IS NULL;

SELECT * FROM orders WHERE comments IS NULL;

SELECT * FROM customers WHERE phone IS NULL;

SELECT * FROM customers WHERE phone =0; -- Not considered as null
SELECT * FROM customers WHERE phone =''; -- not considered as null

#WHERE clause with comparison operators
-- >, <, >=, <=, =, <> or != (not equals)

SELECT firstname,lastname,jobtitle FROM employees WHERE jobtitle <> 'Sales Rap';

SELECT lastname, firstname, officeCode FROM employees
WHERE officecode > 5;

#MySQL ORDER BY clause
-- When you use the SELECT statement to query data from a table, 
-- the result set is not sorted. It means that the rows in the result set can 
-- be in any order.

 

-- To sort the result set, you add the ORDER BY clause to the SELECT statement
/* Syntax:
SELECT   select_list FROM    table_name
ORDER BY 
   column1 [ASC|DESC], 
   column2 [ASC|DESC],
   ...;  */
   
SELECT contactLastName,contactFirstName FROM customers ORDER BY contactLastName;

SELECT contactLastName,contactFirstName FROM customers ORDER BY contactLastName DESC;

SELECT productCode, productName, buyPrice FROM products ORDER BY buyPrice DESC; 

-- Sorting by relative position in result set

SELECT productCode, productName, buyPrice from products order BY 3 DESC; -- ?

-- Multi Level sorting

SELECT contactLastName,contactFirstName FROM customers ORDER BY contactLastName DESC, contactFirstName ASC;

SELECT jobTitle, firstName FROM employees ORDER BY 1 , 2; -- POSITION of the FIELD NAME 

SELECT jobTitle, firstName FROM employees ORDER BY jobTitle, firstName;


#  ORDER BY to sort a result set by an expression    

SELECT orderNumber, orderlinenumber, quantityOrdered * priceEach FROM orderdetails; -- ?

SELECT orderNumber, orderlinenumber, quantityOrdered * priceEach FROM ORDERDETAILS ORDER BY quantityOrdered * priceEach DESC; -- ?


-- Expressions with column alias names    

SELECT orderNumber, orderlinenumber, quantityOrdered * priceEach AS subTotal FROM ORDERDETAILS ORDER BY subTotal DESC; -- ? change the field name

​ 
# MySQL DISTINCT clause

-- When querying data from a table, you may get duplicate rows. 
-- In order to remove these duplicate rows, 
-- you use the DISTINCT clause in the SELECT statement.

 
/* Syntax: SELECT DISTINCT
    select_list
        FROM
    table_name;  */
    
SELECT lastname FROM employees ORDER BY lastname; -- prints all the employees name

SELECT DISTINCT  lastname FROM employees ORDER BY lastname; -- remove all the duplicate 

SELECT state FROM customers;

SELECT DISTINCT state FROM customers;

-- Distinct with multiple columns -- ?

SELECT state,city FROM customers;

SELECT DISTINCT state, DISTINCT city FROM customers;

SELECT DISTINCT state, city FROM customers WHERE state IS NOT NULL ORDER BY state,city; -- ?


# LIMIT clause
-- is used to retrieve records from one or more tables in a database and limit the number
--  of records returned based on a limit value.

SELECT * FROM customers;

SELECT * FROM customers LIMIT 5;

SELECT * FROM customers order by contactLastname LIMIT 5;


# The offset keyword allows you to offset the no. of record returned by
-- the LIMIT clause.

SELECT * FROM customers LIMIT 5 OFFSET 2;

SELECT DISTINCT STATE FROM customers 
WHERE STATE IS NOT NULL LIMIT 5;


# MySQL AND operator
 /* The AND operator is a logical operator that combines two or more Boolean 
 expressions and returns true only if both expressions evaluate to true. 
 The AND operator returns false if one of the two expressions evaluate to false. */

 

 -- Syntax: boolean_expression_1 AND boolean_expression_2
 
 SELECT 1=0 AND 1/0;
 
 SELECT customername,country,state
FROM customers
WHERE country = 'USA' AND state = 'CA';
 
SELECT customername,country,state,creditlimit
FROM customers
WHERE country = 'USA' AND state = 'CA' AND creditlimit > 100000;


# The MySQL OR operator combines two Boolean expressions and returns true when
# either condition is true.
-- Operator Precedence OR then AND

SELECT customername,    country
FROM customers
WHERE country = 'USA' OR country = 'France';

SELECT customername, country, creditLimit
FROM customers
WHERE(country = 'USA'OR country = 'France')
      AND creditlimit > 100000;
      
SELECT customername, country, creditLimit
FROM customers
WHERE creditlimit > 100000 AND (country = 'USA'OR country = 'France');
-- ORDER BY customers DESC;
  
  
# MySQL alias for columns
-- Sometimes, column names are so technical that make the query’s output very
-- difficult to understand. To give a column a descriptive name, you can use a
-- column alias.

/* Syntax:
SELECT
   [column_1 | expression] AS descriptive_name
FROM table_name;  */
          
 SELECT CONCAT(Lastname,' , ', firstname) FROM employees;                 
          
SELECT CONCAT(Lastname,' , ', firstname) AS 'FULL NAME' FROM employees;



---- Alias names can be used order by , group b & having clauses  

# Alis name for Tables.

 SELECT * FROM EMPLOYEES e;
      
 SELECT e.firstName , e.lastName FROM employees e  ORDER BY e.firstName;    

 
# MySQL GROUP BY clause
 -- The GROUP BY clause groups a set of rows into a set of summary rows by values
 -- of columns or expressions. The GROUP BY clause returns one row for each group.
 -- In other words, it reduces the number of rows in the result set.

 /* You often use the GROUP BY clause with aggregate functions such as SUM, AVG,
 MAX, MIN, and COUNT. The aggregate function that appears in the SELECT clause
 provides information about each group. */  
          
/* Syntax:
 SELECT c1, c2,..., cn, aggregate_function(ci)
FROM table
WHERE where_conditions
GROUP BY c1 , c2,...,cn; */


SELECT STATUS FROM orders;

SELECT STATUS FROM orders GROUP BY STATUS; -- it will remove duplicate values 


SELECT STATUS, COUNT(*) AS Total FROM orders GROUP BY STATUS; -- it will count the number and keep in total

SELECT COUNT(*) AS 'Total orders' FROM orders; -- while create new column or rename the column name

SELECT COUNT(*) AS 'total employees' FROM employees;


SELECT SUM(quantityInStock) AS 'Total quanity' FROM products;

SELECT productLine,Sum(quantityInStock) FROM products
GROUP BY productLine;


/* The GROUP BY clause is often used with an aggregate function to perform calculation and
return a single value for each subgroup. */

SELECT orderDate FROM orders;

SELECT YEAR(orderDate) AS 'Year', COUNT(orderNumber) FROM orders
GROUP BY YEAR DESC;

SELECT orderNumber, SUM(quantityOrdered * priceEach) AS Total FROM orderdetails
GROUP BY ordernumber;


-- Design a query to display total no. of customers in each city



SELECT city,COUNT(customername) AS totalCustomers FROM customers GROUP BY city


-- Design a query using max function to return name of the productline
-- and maximim buyPrice for each productLine
	
	SELECT MAX(productLine) AS 'Max Higest' , MAX(buyPrice) AS 'Max price' FROM products
	GROUP BY productLine;


   SELECT productline,MAX(buyprice) as price FROM products GROUP BY productline;
   
-- Display total no of sales rep  -- ?

SELECT job Title, COUNT(*) AS Total FROM employee
WHERE jobtitle = 'Sales Rep' -- group by jobtitleemployees

 
# MySQL HAVING clause

 -- The  HAVING clause is used in the SELECT statement to specify filter
 -- conditions for a group of rows or aggregates
 -- The HAVING clause is often used with the GROUP BY clause to filter groups
 -- based on a specified condition.

 /* Syntax :
 SELECT select_list FROM table_name
WHERE search_condition
GROUP BY group_by_expression
HAVING group_condition;  */ 

SELECT city, COUNT(*) AS 'TotalCustomers' FROM customers
GROUP BY city HAVING TotalCustomers >=3;

SELECT ordernumber,
    SUM(quantityOrdered) AS itemsCount,
    SUM(priceeach*quantityOrdered) AS total
FROM orderdetails GROUP BY ordernumber
HAVING total > 5000;   


SELECT ordernumber,
    SUM(quantityOrdered) AS itemsCount,
    SUM(priceeach*quantityOrdered) AS total
FROM orderdetails GROUP BY ordernumber
HAVING total > 5000 AND itemsCount > 100;


SELECT ordernumber,
    SUM(quantityOrdered) AS itemsCount,
    SUM(priceeach*quantityOrdered) AS total
FROM orderdetails GROUP BY ordernumber
HAVING total > 5000 AND itemsCount > 100 AND ordernumber > 10400;


#ROLLUP
-- ROLLUP” is a modifier that is used with GROUP BY clause.
-- Mainly, it causes the summary output to include extra rows that
-- represent higher-level summary operations.


SELECT productline, SUM(buyprice) FROM products GROUP BY productline WITH ROLLUP; // it will display grand total

SELECT city, COUNT(*) AS 'Total Customers' FROM customers
GROUP BY city WITH ROLLUP;

-- Grouping Based on single fields
SELECT YEAR(orderDate) AS Year, COUNT(orderNumber) from orders
             group by Year DESC

SELECT YEAR(orderDate) AS Year, COUNT(orderNumber) from orders
             group by Year DESC WITH ROLLUP;  
   
	
-- Grouping based on multiple fields

SELECT YEAR(orderDate) AS YEAR, STATUS, COUNT(orderNumber) from orders
             group by Year DESC;
         
SELECT YEAR(orderDate) AS YEAR, STATUS, COUNT(orderNumber) from orders
             group by Year DESC WITH ROLLUP;  
             
             
# Scalar Functions

-- MySQL Scalar Functions allow you to perform different calculations
-- on data values.
-- These functions operate on single rows only and produce one result
-- per row.
/* String functions – functions that perform operations on character values.
Numeric functions – functions that perform operations on numeric values.
Date functions – functions that perform operations on date values.
Conversion functions – functions that convert column data types.
NULL-related Functions – functions for handling null values.
*/            
   
-- String Functions 

SELECT LENGTH('Hello World');

SELECT CONCAT('JDBC', 'SQL'); -- JOIN TWO STRING 

SELECT INSTR('JDBC','B'); -- RETURN LOCATION OF SUBSTRING IN A STRING

SELECT TRIM('JDBC   SQL'); -- TRUNCATES OR REMOVES EXTRA SPACES

SELECT LENGTH('     SQL'); -- THIS WILL ADD ALL SPACES 


SELECT SUBSTR('JDBC',3,1); -- Returns part of a string - specific pos,no. of characters


SELECT UPPER(CustomerName) AS CUSTOMERNAME, CITY FROM customers;


SELECT LOWER(CustomerName) AS CUSTOMERNAME, MID(CITY,1,3) FROM customers;

SELECT UPPER(CONCAT(contactFirstName,' ', contactLastName)) AS  'FULL NAME', 
REVERSE(COUNTRY), REPLACE(state,'NY','KA')  FROM customers;

-- Data Functions

SELECT NOW(); -- show date and time

SELECT CURRENT_DATE; -- shows current date

SELECT SYSDATE();

SELECT productName, buyPrice, NOW() AS 'perDate and TIME' FROM products;

-- DATEDIFF function calculates the number of days between two dates


SELECT DATEDIFF(CURRENT_DATE, '2021-02-01');

-- To calculate the number of days between the required date and
-- shipped date of the orders

SELECT orderNUmber,DATEDIFF(requiredDate,shippedDate) AS 'DaysLeft' FROM orders
ORDER BY DaysLeft DESC;

-- gets all orders whose statuses are in-process and calculates the number of
-- days between ordered date and required date

SELECT orderNUmber,DATEDIFF(requiredDate,orderDate) AS 'remainingDays' FROM orders
where STATUS = 'In process' ORDER BY remainingDays DESC;

 -- The DAY() function returns the day of the month of a given date. 

SELECT DAY(NOW());

SELECT DAY(LAST_DAY('2021-03-01'));

-- return the number of orders by day number in 2004.  -- ?
SELECT DAY(orderdate) DAYOFMONTH,COUNT(*) FROM orders WHERE
YEAR(orderdate)=2004 GROUP BY DAYOFMONTH ORDER BY DAYOFMONTH; -- ?


SELECT DAYNAME(NOW()), WEEKDAY(CURRENT_DATE); -- weekday startes from monday-0;


-- Numeric functions

-- The ABS() function is a mathematical function that returns the absolute (positive)
-- value of a number.

SELECT ABS(-10), ABS(-0),ABS(10)--- ABS(-19*2); -- ?


SELECT buyprice-MSRP, ABS(buyprice-msrp) FROM products;


-- The ROUND() is a mathematical function that allows you to round a number to a specified
-- number of decimal places.

SELECT ROUND(20.5), ROUND(20.7), ROUND(20.1);

SELECT ROUND(20.789,1) , ROUND (20.5,0);\


-- The number of decimal places ( d) can be positive or negative.
-- If it is negative, then the d digits left of the decimal point of the number n becomes zero.

SELECT ROUND(121.55,-2), ROUND (2013.567,-3)

SELECT productCode, AVG(quantityOrdered*priceEach) average_item_value FROM orderdetails GROUP BY productcode;

SELECT productCode, ROUND(AVG(quantityOrdered*priceEach)) average_item_value FROM orderdetails GROUP BY productcode;


-- ceil() & floor()
-- The CEIL() function takes an input number and returns 
-- the smallest integer greater than or equal to that number.

 
-- FLOOR() -Returns the largest integer value not greater than the argument

SELECT FLOOR(59.9), CEIL (59.1);

SELECT productLine, CEIL(AVG(msrp)) as averagemsrp FROM products GROUP BY productLine
ORDER BY averagemsrp;


# Conversion functions

 

-- FORMAT() -- Converts number in to a String
-- DATE_FORMAT() -Converts DATE  in to a String
-- CONVERT() -- converting string to number/date/Time

SELECT DATE_FORMAT(NOW(),' %Y %M %D');  -- FORMATING DATE

SELECT FORMAT(1002343,2), FORMAT(1002343.2345,2);

SELECT CONVERT ('100', UNSIGNED INTEGER), CONVERT('-100', SIGNED INTEGER);

SELECT CONVERT('2017-12-31', DATE), CONVERT('8:23:23', TIME);

# NULL Related Functions

-- IFNULL()  - Return the specified value IF the expression is NULL,
-- otherwise return the expression

SELECT IFNULL(NULL, 'Hello');

SELECT customerName,city,state FROM customers;

SELECT customerName,city,IFNULL(state, 'KA') FROM customers;

SELECT orderNumber, comments FROM orders;

SELECT orderNumber, IFNULL(comments,'CHECK') FROM orders;

SELECT AVG(buyPRICE) FROM products;

SELECT AVG(IFNULL(buyPRICE,0)) FROM products;