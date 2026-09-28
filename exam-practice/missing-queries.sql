USE structured_sql_lab;

/* MISSING / STRENGTHENING QUERIES FOR THE SYLLABUS */

-- JOINS: FULL OUTER JOIN concept
SELECT r.id, r.name, o.order_id
FROM restaurants r
LEFT JOIN orders1 o ON r.id = o.restaurant_id
UNION
SELECT r.id, r.name, o.order_id
FROM restaurants r
RIGHT JOIN orders1 o ON r.id = o.restaurant_id;

-- SUBQUERIES: NOT EXISTS
SELECT e.emp_name
FROM employees e
WHERE NOT EXISTS (
    SELECT 1
    FROM departments d
    WHERE d.dept_id = e.dept_id
);

-- SUBQUERIES: correlated
SELECT e.emp_name, e.salary
FROM employees e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.dept_id = e.dept_id
);

-- SUBQUERIES: ANY
SELECT emp_name, salary
FROM employees
WHERE salary > ANY (
    SELECT salary FROM employees WHERE dept_id = 10
);

-- SUBQUERIES: ALL
SELECT emp_name, salary
FROM employees
WHERE salary > ALL (
    SELECT salary FROM employees WHERE dept_id = 30
);

-- INDEXING: composite index
CREATE INDEX idx_department_city
ON index_demo(department, city);

EXPLAIN SELECT *
FROM index_demo
WHERE department = 'Data Science'
  AND city = 'Chennai';

-- VIEWS: inspect and remove
SHOW FULL TABLES WHERE TABLE_TYPE = 'VIEW';
-- DROP VIEW high_earners;

-- REGEXP: common operators
SELECT * FROM items WHERE item_code REGEXP '^ITEM';
SELECT * FROM items WHERE description REGEXP 'fruit$';
SELECT * FROM items WHERE description REGEXP 'apple|banana';
SELECT * FROM items WHERE item_code REGEXP '[0-9]+';

-- WINDOW: AVG and COUNT
SELECT employee, department, amount,
       AVG(amount) OVER (PARTITION BY department) AS dept_avg,
       COUNT(*) OVER (PARTITION BY department) AS dept_count
FROM sales;

-- PARTITION: range/hash theory is represented in notes; the runnable
-- example is in sql/07-partition/partition.sql.

-- BCNF: complete FD -> violation -> decomposition workflow
-- is in sql/09-bcnf/bcnf.sql.
