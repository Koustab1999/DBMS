# SQL Joins
-- A join is a method of linking data between one (self-join) or 
-- more tables based on values of the common column between the tables.

 

/* MySQL supports the following types of joins:

 

Inner join
Left join
Right join
Cross join */


-- Inner Join - Returns only matching records from 2 tables

/* SELECT
    select_list
FROM t1
INNER JOIN t2 ON join_condition1
INNER JOIN t3 ON join_condition2
...; */

-- Query to dsipaly productCode and productName from the products table.
-- and  textDescription of product lines from the productlines table.
USE classicmodels;

/*SELECT customernumber, ordernumber FROM customers t1 
INNER JOIN orders t2
ON t1.customerNumber = t2.customerNumber;*/

SELECT productCode, productName, textDescription FROM products t1
INNER JOIN productlines t2
ON t1.productline = t2.productline;

SELECT productCode, productName, textDescription
FROM products
ineer JOIN productlines
ON products.productLine = productlines.productline;

-- Query to display employeecode, emp firstname & city

SELECT employeeNumber, firstName, city FROM employees t1
INNER JOIN offices t2
ON t1.officeCode = t2.officeCode;

-- USING clause -- if joined fields of both tables have smae name

SELECT employeeNumber, firstName, city FROM employees t1
INNER JOIN offices t2
USING(officeCode);

-- Inner join with group by clause

SELECT t1.orderNumber, t1.status, SUM(quantityOrdered * priceEach) as total  
FROM orders t1 INNER JOIN orderdetails t2
ON t1.orderNumber = t2.orderNumber
GROUP BY orderNUmber;


-- Join 3 tables

SELECT orderNumber, orderDate, orderLineNumber, productName,quantityOrdered,
priceEach FROM orders INNER JOIN orderdetails USING (orderNumber)
							 INNER JOIN products USING(productCode)
							 ORDER BY orderNumber, orderLineNumber;
							 
							 
SELECT orderNumber, orderDate, orderLineNumber, productName,quantityOrdered,
priceEach FROM orders t1
 			INNER JOIN orderdetails t2 
 			ON t1.orderNumber = t2.orderNumber
			 INNER JOIN products t3     
				ON  t2.productCode = t3.productCode;
				 -- ORDER BY orderNumber, productCode; 
 
 -- joins with operators
 -- The following query uses a less-than ( <) join to find sales price of the
-- product whose code is S10_1678 that is less than the manufacturer’s
-- suggested retail price (MSRP) for that product.
 
 SELECT orderNumber, productName, msrp, priceEach FROM products p
 				INNER JOIN orderdetails o 
 				ON p.productCode=o.productCode
 				AND p.MSRP > o.priceEach
 				WHERE p.productCode = 'S10_1678';
 
 # lEFT OUTER JOIN
-- LEFT JOIN returns all rows from the left table regardless of whether a row
-- from the left table has a matching row from the right table or not.
-- If there is no match, the columns of the row from the right table will contain NULL.
    		

-- This query uses the LEFT JOIN clause to find all customers and their orders:			 
SELECT c.customerNumber, customerName, orderNumber, STATUS FROM customers c
		LEFT JOIN orders o   -- RIGHT TABLE IS CUSTOMERS AND LEFT TABLE IS ORDERS
		ON c.customerNumber = o.customerNumber;
		
-- LEFT JOIN to find customers who have no order:		
SELECT c.customerNumber, c.customerNumber, o.orderNumber, STATUS FROM customers c
		LEFT JOIN orders o   
		ON c.customerNumber = o.customerNumber
		WHERE orderNumber IS NULL;	
	--	WHERE IFNULL(ORDERNUMBER,'HI');	
	
SELECT o.orderNumber, o.customerNumber, d.productCode FROM orders o
			LEFT JOIN orderdetails d
			ON o.orderNumber = d.orderNumber
			AND o.orderNumber = 10123; 	
			
# right join -- ?
SELECT customerNumber, employeeNUmber FROM customers
RIGHT JOIN employees
ON salesRepEmployeeNumber = employeeNumber
ORDER BY employeeNumber;	


#Full Outer Join

 

-- returns all rows from the left table (table1) and from the 
-- right table (table2).

-- MY SQL DOESNOT SUPPORT FULL JOIN.. INSTEAD USE UNION WITH LEFT/RIGHT JOINS
SELECT c.customerNumber, customerName, orderNumber, STATUS FROM
customers c
		LEFT JOIN orders o   
		ON c.customerNumber = o.customerNumber;
		
UNION 

SELECT c.customerNumber, customerName, orderNumber, STATUS FROM 
customers c
		RIGHT JOIN orders o   
		ON c.customerNumber = o.customerNumber;
		
		
#Self Join
-- The self join is often used to query hierarchical data or to compare a row
-- with other rows within the same table.

SELECT CONCAT(e.lastName,' ',e.firstName) AS Employees,
CONCAT(m.lastName,' ',m.firstName) AS 'Reports to'
FROM employees e INNER JOIN employees m
		ON e.reportsTO=m.employeeNumber;
		
SELECT CONCAT(e.lastName,' ',e.firstName) AS Employees,
CONCAT(m.lastName,' ',m.firstName) AS 'Reports to'
FROM employees e LEFT JOIN employees m
		ON e.reportsTO=m.employeeNumber;		
		
		
		
		

    #Sub Query
-- A MySQL subquery is a query that is nested inside another query.
-- A MySQL subquery is called an inner query while the query that contains the
-- subquery is called an outer query.
-- Sub query acts a criteria for Outer query.

    
-- Syntax: SELECT * FROM t1 WHERE column1 = (SELECT column1 FROM t2);


-- query returns employees who work in offices located in the USA.
SELECT lastname, firstname FROM employees WHERE officecode
IN(SELECT officecode FROM offices WHERE country='USA');	


-- query returns the customer who has the maximum payment.

SELECT customerNumber, checkNumber, amount FROM payments
WHERE amount = (SELECT MAX(amount) FROM payments);

--  find customers whose payments are greater than the average payment


SELECT customerNumber, checkNumber, amount FROM payments
WHERE amount > (SELECT AVG(amount) FROM payments);	


-- find the customers who have not placed any orders

SELECT CUSTOMERNAME FROM CUSTOMERS
WHERE CUSTOMERNUMBER NOT IN (SELECT DISTINCT CUSTOMERNUMBER FROM orders);


-- diplay products with price greater than '1958 setra bus'

SELECT productName FROM products 
WHERE buyPrice > (SELECT buyPrice FROM products WHERE productName='1958 Setra Bus');



#Views
-- It is Virtual Table
--  view is a named query stored in the database catalog.
-- Complex queries or frequently used queries can be saved as views and can be
-- queried later as a normal Table

    SELECT employeeNumber, firstName, city from employees e
    INNER JOIN offices o
        ON e.officeCode=o.officeCode;
        
CREATE VIEW empLocations AS  -- syntax
    SELECT employeeNumber, firstName, city from employees e
    INNER JOIN offices o
        ON e.officeCode=o.officeCode;
        
        
-- query view as normal table

SELECT * FROM emplocations;    

SELECT * FROM emplocations WHERE city = 'Boston'; 

SELECT * FROM emplocations WHERE firstName LIKE 'A%';    

CREATE VIEW vquickContactCut AS 
SELECT customerNumber,customerName,phone,city,country FROM customers;

SELECT * FROM vquickContactCut;



CREATE VIEW daysofweek (day) AS
    SELECT 'Mon' 
    UNION 
    SELECT 'Tue'
    UNION 
    SELECT 'Web'
    UNION 
    SELECT 'Thu'
    UNION 
    SELECT 'Fri'
    UNION 
    SELECT 'Sat'
    UNION 
    SELECT 'Sun';
    
    
 SELECT * FROM daysofweek;   
 
 
 SHOW TABLES; -- list tables & views
 
 
 CREATE VIEW salePerOrder AS 
 SELECT orderNumber, SUM(quantityOrdered * priceEach) AS  total FROM orderDetails
  GROUP by orderNumber
   ORDER BY total DESC;
   
   SELECT * FROM salePerOrder;
   
   
CREATE OR REPLACE VIEW customerOrders AS
SELECT orderNumber, customerName, SUM(quantityOrdered * priceEach) total FROM orderdetails 
INNER JOIN orders o USING (orderNumber) 
INNER JOIN customers USING (customerNumber) 
GROUP BY orderNumber;   


SELECT * FROM customerOrders ;

SELECT * FROM customerOrders ORDER BY total DESC;