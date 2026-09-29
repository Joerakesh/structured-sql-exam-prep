CREATE DATABASE structured_sql;
USE structured_sql;

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

INSERT INTO departments VALUES
(1, 'Data Science'),
(2, 'Computer Science'),
(3, 'Commerce'),
(4, 'Mathematics');

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    salary DECIMAL(10,2),
    manager_id INT
);

INSERT INTO employees VALUES
(101, 'Alice', 1, 60000, NULL),
(102, 'Bob', 1, 55000, 101),
(103, 'Carol', 2, 50000, 101),
(104, 'David', 2, 45000, 103),
(105, 'Eve', NULL, 40000, 101),
(106, 'Frank', 3, 35000, NULL);

-- INNER JOIN
SELECT
    e.emp_id,
    e.emp_name,
    d.dept_name
FROM employees e
INNER JOIN departments d
    ON e.dept_id = d.dept_id;

-- LEFT JOIN
SELECT
    e.emp_id,
    e.emp_name,
    d.dept_name
FROM employees e
LEFT JOIN departments d
    ON e.dept_id = d.dept_id;

-- RIGHT JOIN
SELECT
    e.emp_id,
    e.emp_name,
    d.dept_name
FROM employees e
RIGHT JOIN departments d
    ON e.dept_id = d.dept_id;

-- FULL OUTER JOIN
SELECT
    e.emp_id,
    e.emp_name,
    d.dept_name
FROM employees e
LEFT JOIN departments d
    ON e.dept_id = d.dept_id

UNION

SELECT
    e.emp_id,
    e.emp_name,
    d.dept_name
FROM employees e
RIGHT JOIN departments d
    ON e.dept_id = d.dept_id;

-- SELF JOIN
SELECT
    e.emp_name AS employee,
    m.emp_name AS manager
FROM employees e
LEFT JOIN employees m
    ON e.manager_id = m.emp_id;

-- JOIN + WHERE
SELECT
    e.emp_name,
    e.salary
FROM employees e
JOIN departments d
    ON e.dept_id = d.dept_id
WHERE d.dept_name = 'Data Science';

-- JOIN + GROUP BY
SELECT
    d.dept_name,
    AVG(e.salary) AS average_salary
FROM employees e
JOIN departments d
    ON e.dept_id = d.dept_id
GROUP BY d.dept_name;

-- JOIN + ORDER BY
SELECT
    e.emp_name,
    d.dept_name,
    e.salary
FROM employees e
JOIN departments d
    ON e.dept_id = d.dept_id
ORDER BY e.salary DESC;