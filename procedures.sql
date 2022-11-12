DROP PROCEDURE IF EXISTS GetAllProducts;

DELIMITER //

CREATE PROCEDURE GetAllProducts()
BEGIN
	SELECT *  FROM products;
    select * from orders;
END //

DELIMITER ;

call GetAllProducts;

DROP PROCEDURE IF EXISTS GetOfficeByCountry;

DELIMITER //

CREATE PROCEDURE GetOfficeByCountry(
	IN countryName VARCHAR(255)
)
BEGIN
	SELECT * 
 		FROM offices
			WHERE country = countryName;
END //
DELIMITER ;

Call GetOfficeByCountry('USA');

DROP PROCEDURE IF EXISTS GetFirstX;

DELIMITER //

CREATE PROCEDURE GetFirstX(
	IN x INT
)
BEGIN
	SELECT * 
 		FROM payments
			Limit x;
END //
DELIMITER ;
call GetFirstX(10);


DROP PROCEDURE IF EXISTS GetOrderCountByStatus;

DELIMITER $$

CREATE PROCEDURE GetOrderCountByStatus (
	IN  orderStatus VARCHAR(25),
	OUT total INT
)
BEGIN
	SELECT COUNT(orderNumber)
	INTO total
	FROM orders
	WHERE status = orderStatus;
END$$
DELIMITER ;

Call GetOrderCountByStatus ('Shipped',@total);
Select @total;

DROP PROCEDURE IF EXISTS GetOrderAmountOfXth;

DELIMITER $$

CREATE PROCEDURE GetOrderAmountOfXth (
	IN  x INT,
	OUT amountout decimal(10,2)
)
BEGIN
	Set x = x-1;
    SELECT amount
	INTO amountout
	FROM payments
    Limit X,1;
	
END$$
DELIMITER ;

Call GetOrderAmountOfXth (5,@amountout);
Select @amountout;

DROP PROCEDURE IF EXISTS SetCounter;

DELIMITER $$

Select * from classicmodels.customers;

DROP PROCEDURE IF EXISTS GetCustomerLevel;

DELIMITER $$

CREATE PROCEDURE GetCustomerLevel(
    	IN  pCustomerNumber INT, 
    	OUT pCustomerLevel  VARCHAR(20)
)
BEGIN
	DECLARE credit DECIMAL DEFAULT 0;

	SELECT creditLimit 
		INTO credit
			FROM customers
				WHERE customerNumber = pCustomerNumber;

	IF credit > 50000 THEN
		SET pCustomerLevel = 'PLATINUM';
	ELSE
		SET pCustomerLevel = 'NOT PLATINUM';
	END IF;
END$$
DELIMITER ;

call GetCustomerLevel(447,@Level);
Select @Level;


DROP PROCEDURE IF EXISTS GetCategory;

DELIMITER $$

CREATE PROCEDURE GetCategory(
    	IN  rownumber INT, 
    	OUT category  VARCHAR(5)
)
BEGIN
	DECLARE rownumberxamount DECIMAL DEFAULT 0;

	Set rownumber = rownumber-1;
	SELECT amount 
		INTO rownumberxamount
			FROM payments
				limit rownumber,1;

	IF rownumberxamount > 100000 THEN
		SET category = 'CAT1';
	ELSEIf rownumberxamount > 10000 Then
        Set category ='CAT2';
       else 
		SET category = 'CAT3';
	END IF;
END$$
DELIMITER ;

call GetCategory(5,@Category);
Select @Category;