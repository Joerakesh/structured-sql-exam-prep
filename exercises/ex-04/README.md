# Ex.No 4 - User Defined Function (UDF)

**Script:** [`ex04_udf.sql`](ex04_udf.sql)

## Aim
Create a stored function in MySQL and call it inside a `SELECT`.

## The function
```sql
DELIMITER //
CREATE FUNCTION AddNumbers(num1 INT, num2 INT)
RETURNS INT NO SQL
BEGIN
    RETURN num1 + num2;
END//
DELIMITER ;

SELECT AddNumbers(4, 5) AS Addition;
```

## Line-by-line

| Part | Meaning |
|---|---|
| `DELIMITER //` | Changes the statement terminator so the `;` inside the function body does not end the `CREATE FUNCTION` early |
| `CREATE FUNCTION AddNumbers(num1 INT, num2 INT)` | Names the function and declares two integer parameters |
| `RETURNS INT` | Declares the data type of the returned value (mandatory for functions) |
| `NO SQL` | Characteristic stating the body contains no SQL statements |
| `BEGIN ... END` | The function body |
| `RETURN num1 + num2;` | Computes and returns the result |
| `DELIMITER ;` | Restores the normal terminator |

## Expected output

| Addition |
|---|
| 9 |

## Exam points
- A **function** must `RETURN` a value and can be used inside `SELECT`; a **procedure** is run with `CALL` and can return values through `OUT` parameters.
- Forgetting `DELIMITER` is the most common error: MySQL stops at the first `;`.
- Drop a function with `DROP FUNCTION IF EXISTS AddNumbers;`.
- `DELIMITER` is a client command (MySQL Workbench and the `mysql` CLI understand it), not SQL sent to the server.
