-- Ex.No: 3 - String Manipulation

-- a) ASCII conversion of status codes
SELECT id, status_code, ASCII(status_code) AS ascii_code
FROM shipments;

-- b) Extract email domain using LOCATE() and string slicing
SELECT id, email,
       SUBSTRING(email, LOCATE('@', email) + 1) AS email_domain
FROM users;

-- c) Compare old_status and new_status using STRCMP() and group counts
SELECT old_status, new_status,
       STRCMP(old_status, new_status) AS comparison_result,
       COUNT(*) AS total_count
FROM orders_audit
GROUP BY old_status, new_status, STRCMP(old_status, new_status);

-- d) Convert integer permissions to binary
SELECT user_id, permission, BIN(permission) AS binary_permission
FROM user_permissions;

-- e) Extract production year from the 12-character serial code
SELECT id, serial_code,
       SUBSTRING(serial_code, 1, 4) AS manufacturing_year
FROM inventory;

-- f) Format account number and account name
SELECT id,
       LPAD(account_number, 10, '0') AS formatted_account_number,
       RPAD(account_name, 20, ' ') AS formatted_account_name
FROM accounts;
