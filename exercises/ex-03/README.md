# Ex.No 3 - String Manipulation

**Script:** [`ex03_string_manipulation.sql`](ex03_string_manipulation.sql)
**Tables used:** `shipments`, `users`, `orders_audit`, `user_permissions`, `inventory`, `accounts`

## Aim
Six practical string-manipulation problems (a to f) combining functions such as `ASCII`, `LOCATE`, `SUBSTRING`, `STRCMP`, `BIN`, `LPAD` and `RPAD`.

## Setup
The script has only the `SELECT` queries; the six tables come from the Classroom exercise and are not created here. To test on your own machine, use this sample data:

```sql
CREATE TABLE shipments (id INT, status_code CHAR(1));
INSERT INTO shipments VALUES (1,'A'),(2,'D'),(3,'Z');
CREATE TABLE users (id INT, email VARCHAR(100));
INSERT INTO users VALUES (1,'arun@example.com'),(2,'priya@gmail.com');
CREATE TABLE orders_audit (id INT, old_status VARCHAR(20), new_status VARCHAR(20));
INSERT INTO orders_audit VALUES (1,'pending','shipped'),(2,'pending','shipped'),(3,'shipped','shipped'),(4,'shipped','delivered');
CREATE TABLE user_permissions (user_id INT, permission INT);
INSERT INTO user_permissions VALUES (1,5),(2,7),(3,12);
CREATE TABLE inventory (id INT, serial_code CHAR(12));
INSERT INTO inventory VALUES (1,'2024AB123456'),(2,'2021XY987654');
CREATE TABLE accounts (id INT, account_number VARCHAR(10), account_name VARCHAR(30));
INSERT INTO accounts VALUES (1,'12345','Arun'),(2,'9876543','Priya');
```

## Problems

### a) ASCII conversion of status codes
`ASCII(status_code)` returns the numeric code of the first character.

| id | status_code | ascii_code |
|---|---|---|
| 1 | A | 65 |
| 2 | D | 68 |
| 3 | Z | 90 |

### b) Extract the email domain
`LOCATE('@', email)` finds the position of `@`; `SUBSTRING(email, pos + 1)` takes everything after it.

| id | email | email_domain |
|---|---|---|
| 1 | arun@example.com | example.com |
| 2 | priya@gmail.com | gmail.com |

### c) Compare old and new status with a group count
`STRCMP` returns `-1`, `0` or `1`; grouping counts how often each transition occurs.

| old_status | new_status | comparison_result | total_count |
|---|---|---|---|
| pending | shipped | -1 | 2 |
| shipped | shipped | 0 | 1 |
| shipped | delivered | 1 | 1 |

### d) Integer permissions to binary
`BIN(permission)` returns the binary representation as a string.

| user_id | permission | binary_permission |
|---|---|---|
| 1 | 5 | 101 |
| 2 | 7 | 111 |
| 3 | 12 | 1100 |

### e) Production year from a 12-character serial code
`SUBSTRING(serial_code, 1, 4)` takes the first four characters (assumes the year is at the start of the code).

| id | serial_code | manufacturing_year |
|---|---|---|
| 1 | 2024AB123456 | 2024 |
| 2 | 2021XY987654 | 2021 |

### f) Format account number and name
`LPAD(account_number, 10, '0')` pads with zeros on the left; `RPAD(account_name, 20, ' ')` pads with spaces on the right to a fixed width.

| id | formatted_account_number | formatted_account_name |
|---|---|---|
| 1 | 0000012345 | Arun (padded to 20 chars) |
| 2 | 0009876543 | Priya (padded to 20 chars) |

## Exam points
- In (c), every non-aggregated expression in the `SELECT` must also appear in `GROUP BY`, including `STRCMP(...)`.
- `LPAD`/`RPAD` **truncate** the value if it is longer than the target length.
- `BIN` returns text, not a number, so leading zeros are not added.
