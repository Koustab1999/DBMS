use mysqljdbc;

# Regular Expressions
-- It provide a powerful and flexible pattern match that can help us 
-- implement power search utilities for our database systems.
-- REGEXP is the operator used when performing regular expression
-- pattern matches.
-- ^	caret(^) matches Beginning of string
-- $	End of string
-- [0-9]	match any digit from 0 through to 9.

use mysqljdbc;
-- Phone & Email Validation
   
CREATE TABLE Customer
(
    C_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    C_Name VARCHAR(50) NOT NULL,
    Phone VARCHAR(10) CHECK(Phone regexp '^[0-9]{10}$'),
    Email VARCHAR(50) CHECK(Email REGEXP '^[A-Za-z0-9._%\-+
	 !#$&/=?^|~]+@[A-Za-z0-9.-]+[.][A-Za-z]+$')
);                                

INSERT INTO Customer(C_Name,Phone,Email) values('John','1234567','raj@test.com');

INSERT INTO Customer(C_Name,Phone,Email) values('John','1234567891','raj@testcom');

INSERT INTO Customer(C_Name,Phone,Email) values('John','1234567891','rajtest.com');

INSERT INTO Customer(C_Name,Phone,Email) values('Mike','9243390234','mike@test.com');

SELECT * FROM Customer;

/* end date is always greater than or equal to the begin date and the 
begin date is greater than or equal 1970-01-01.*/

CREATE TABLE batches (
  batchid int(11) NOT NULL,
  batchname varchar(255) NOT NULL,
  begindate date NOT NULL,
  enddate date NOT NULL,
  CONSTRAINT chk_date CHECK(enddate >= begindate AND begindate >= '1970-01-01')
  )
  
  INSERT INTO batches values(101,'Java',CURRENT_DATE,'2020-12-01');
  
   INSERT INTO batches values(101,'Java',CURRENT_DATE,'2021-12-01');
 
 SELECT * FROM batches; 
  # ---------------------------------------------
  -- Check begindate should be greater then today's date using Triggers
  -- Triggers are stored programs, 
  -- which are automatically executed or fired when some events occurs such as 
  -- Insert, delete ,update etc...
  CREATE TABLE batches1 (
  batchid int(11) NOT NULL,
  batchname varchar(255) NOT NULL,
  begindate date NOT NULL
    )
  
DELIMITER //
  CREATE TRIGGER date_check
BEFORE INSERT ON batches1
FOR EACH ROW
BEGIN
IF NEW.begindate <= CURDATE() THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid date!';
END IF;
END; //
DELIMITER ;

INSERT INTO batches1 values(101,'Java',CURRENT_DATE);
INSERT INTO batches1 values(102,'HTML','2021-02-25');
 
SELECT * FROM batches1;