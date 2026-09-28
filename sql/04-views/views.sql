USE structured_sql_lab;

DROP VIEW IF EXISTS high_earners;
DROP VIEW IF EXISTS employee_department_info;

-- 1. Simple view
CREATE VIEW high_earners AS
SELECT emp_id, emp_name, salary
FROM employees
WHERE salary >= 70000;

SELECT * FROM high_earners;

-- 2. View based on JOIN
CREATE VIEW employee_department_info AS
SELECT e.emp_id, e.emp_name, e.salary, d.dept_name
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id;

SELECT * FROM employee_department_info;

-- 3. Inspect views
SHOW FULL TABLES WHERE TABLE_TYPE = 'VIEW';

-- 4. Remove a view
-- DROP VIEW high_earners;

-- 5. Updateability example.
-- A simple single-table view may be updatable when MySQL's
-- view restrictions are satisfied.
UPDATE high_earners
SET salary = salary + 1000
WHERE emp_id = 1;

SELECT * FROM high_earners;

-- Join/aggregate/derived views are generally not directly updatable.
