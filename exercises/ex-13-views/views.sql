-- ============================================================
-- VIEWS - COMPLETE SQL PRACTICE
-- ============================================================

-- ============================================================
-- 1. CREATE DATABASE
-- ============================================================

CREATE DATABASE views_db;

USE views_db;


-- ============================================================
-- 2. CREATE DEPARTMENTS TABLE
-- ============================================================

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);


-- ============================================================
-- 3. INSERT DEPARTMENT DATA
-- ============================================================

INSERT INTO departments (dept_id, dept_name) VALUES
(1, 'Data Science'),
(2, 'Computer Science'),
(3, 'Commerce'),
(4, 'Mathematics');


-- ============================================================
-- 4. CREATE EMPLOYEES TABLE
-- ============================================================

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    salary DECIMAL(10,2),
    manager_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);


-- ============================================================
-- 5. INSERT EMPLOYEE DATA
-- ============================================================

INSERT INTO employees
(emp_id, emp_name, dept_id, salary, manager_id)
VALUES
(101, 'Alice', 1, 60000, NULL),
(102, 'Bob', 1, 55000, 101),
(103, 'Carol', 2, 50000, 101),
(104, 'David', 2, 45000, 103),
(105, 'Eve', NULL, 40000, 101),
(106, 'Frank', 3, 35000, NULL);


-- ============================================================
-- 6. CHECK TABLE DATA
-- ============================================================

SELECT * FROM departments;

SELECT * FROM employees;


-- ============================================================
-- 7. SIMPLE VIEW
-- ============================================================

CREATE VIEW employee_details AS
SELECT
    emp_id,
    emp_name,
    salary
FROM employees;


-- View data

SELECT * FROM employee_details;


-- ============================================================
-- 8. VIEW WITH WHERE
-- ============================================================

CREATE VIEW high_salary_employees AS
SELECT
    emp_id,
    emp_name,
    salary
FROM employees
WHERE salary >= 50000;


-- View data

SELECT * FROM high_salary_employees;


-- ============================================================
-- 9. VIEW USING JOIN
-- ============================================================

CREATE VIEW employee_department AS
SELECT
    e.emp_id,
    e.emp_name,
    d.dept_name,
    e.salary
FROM employees e
JOIN departments d
    ON e.dept_id = d.dept_id;


-- View data

SELECT * FROM employee_department;


-- ============================================================
-- 10. VIEW WITH GROUP BY
-- ============================================================

CREATE VIEW department_salary_summary AS
SELECT
    d.dept_name,
    COUNT(e.emp_id) AS employee_count,
    AVG(e.salary) AS average_salary
FROM departments d
LEFT JOIN employees e
    ON d.dept_id = e.dept_id
GROUP BY d.dept_name;


-- View data

SELECT * FROM department_salary_summary;


-- ============================================================
-- 11. VIEW WITH ORDER BY
-- ============================================================

CREATE VIEW employee_salary_details AS
SELECT
    emp_id,
    emp_name,
    salary
FROM employees
ORDER BY salary DESC;


-- View data

SELECT * FROM employee_salary_details;


-- ============================================================
-- 12. QUERY A VIEW WITH WHERE
-- ============================================================

SELECT *
FROM employee_department
WHERE salary > 50000;


-- ============================================================
-- 13. QUERY A VIEW WITH ORDER BY
-- ============================================================

SELECT *
FROM employee_details
ORDER BY salary DESC;


-- ============================================================
-- 14. QUERY A VIEW WITH WHERE + ORDER BY
-- ============================================================

SELECT *
FROM employee_details
WHERE salary >= 50000
ORDER BY salary DESC;


-- ============================================================
-- 15. SHOW VIEW DEFINITION
-- ============================================================

SHOW CREATE VIEW employee_details;


-- ============================================================
-- 16. LIST ALL VIEWS
-- ============================================================

SHOW FULL TABLES
WHERE TABLE_TYPE = 'VIEW';


-- ============================================================
-- 17. UPDATE DATA THROUGH SIMPLE VIEW
-- ============================================================

UPDATE employee_details
SET salary = 62000
WHERE emp_id = 101;


-- Check updated data

SELECT * FROM employees
WHERE emp_id = 101;


-- ============================================================
-- 18. CREATE OR REPLACE VIEW
-- ============================================================

CREATE OR REPLACE VIEW employee_details AS
SELECT
    emp_id,
    emp_name,
    salary,
    dept_id
FROM employees;


-- Check updated view

SELECT * FROM employee_details;


-- ============================================================
-- 19. ALTER VIEW
-- ============================================================

ALTER VIEW employee_details AS
SELECT
    emp_id,
    emp_name,
    salary
FROM employees
WHERE salary >= 40000;


-- Check altered view

SELECT * FROM employee_details;


-- ============================================================
-- 20. DROP VIEW
-- ============================================================

DROP VIEW employee_salary_details;


-- ============================================================
-- 21. DROP VIEW IF EXISTS
-- ============================================================

DROP VIEW IF EXISTS employee_details;