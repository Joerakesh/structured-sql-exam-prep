USE structured_sql_lab;

DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    salary DECIMAL(10,2)
);

INSERT INTO departments VALUES
(10, 'Data Science'),
(20, 'IT'),
(30, 'HR');

INSERT INTO employees VALUES
(1, 'Arun', 10, 70000),
(2, 'Priya', 10, 85000),
(3, 'Rahul', 20, 60000),
(4, 'Divya', 30, 50000);

-- 1. IN subquery
SELECT emp_name
FROM employees
WHERE dept_id IN (
    SELECT dept_id
    FROM departments
    WHERE dept_name IN ('Data Science', 'IT')
);

-- 2. EXISTS: correlated subquery
SELECT e.emp_name
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM departments d
    WHERE d.dept_id = e.dept_id
);

-- 3. NOT EXISTS
SELECT e.emp_name
FROM employees e
WHERE NOT EXISTS (
    SELECT 1
    FROM departments d
    WHERE d.dept_id = e.dept_id
);

-- 4. Correlated subquery: employees earning more than
-- the average salary of their own department.
SELECT e.emp_name, e.salary, e.dept_id
FROM employees e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.dept_id = e.dept_id
);

-- 5. Scalar subquery: one value returned by the subquery
SELECT emp_name, salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);

-- 6. ANY: salary greater than at least one employee in department 10
SELECT emp_name, salary
FROM employees
WHERE salary > ANY (
    SELECT salary
    FROM employees
    WHERE dept_id = 10
);

-- 7. ALL: salary greater than every employee in department 30
SELECT emp_name, salary
FROM employees
WHERE salary > ALL (
    SELECT salary
    FROM employees
    WHERE dept_id = 30
);
