-- Ex.No: 4 - Using UDF

DELIMITER //
CREATE FUNCTION AddNumbers(num1 INT, num2 INT)
RETURNS INT NO SQL
BEGIN
    RETURN num1 + num2;
END//
DELIMITER ;

SELECT AddNumbers(4, 5) AS Addition;
