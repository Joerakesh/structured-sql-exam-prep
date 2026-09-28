USE structured_sql_lab;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
    id INT PRIMARY KEY,
    employee VARCHAR(50),
    department VARCHAR(50),
    amount DECIMAL(10,2)
);

INSERT INTO sales VALUES
(1, 'Arun', 'Data Science', 5000),
(2, 'Priya', 'Data Science', 7000),
(3, 'Rahul', 'Data Science', 7000),
(4, 'Divya', 'IT', 6000),
(5, 'Kiran', 'IT', 4000);

-- Ranking
SELECT employee, amount,
       ROW_NUMBER() OVER (ORDER BY amount DESC) AS row_num,
       RANK() OVER (ORDER BY amount DESC) AS rank_num,
       DENSE_RANK() OVER (ORDER BY amount DESC) AS dense_rank_num
FROM sales;

-- Ranking inside each department
SELECT employee, department, amount,
       RANK() OVER (
           PARTITION BY department
           ORDER BY amount DESC
       ) AS dept_rank
FROM sales;

-- PERCENT_RANK
SELECT employee, amount,
       PERCENT_RANK() OVER (ORDER BY amount) AS percent_rank
FROM sales;

-- NTILE
SELECT employee, amount,
       NTILE(2) OVER (ORDER BY amount DESC) AS bucket
FROM sales;

-- Previous and next row
SELECT employee, amount,
       LAG(amount) OVER (ORDER BY id) AS previous_amount,
       LEAD(amount) OVER (ORDER BY id) AS next_amount
FROM sales;

-- First, last and nth value
SELECT employee, amount,
       FIRST_VALUE(amount) OVER (ORDER BY amount DESC) AS highest_sale,
       LAST_VALUE(amount) OVER (
           ORDER BY amount DESC
           ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS lowest_sale,
       NTH_VALUE(amount, 4) OVER (
           ORDER BY amount DESC
           ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS fourth_sale
FROM sales;

-- Window aggregate functions
SELECT employee, department, amount,
       AVG(amount) OVER (PARTITION BY department) AS dept_avg,
       COUNT(*) OVER (PARTITION BY department) AS dept_count,
       SUM(amount) OVER (PARTITION BY department) AS dept_total
FROM sales;

-- Running total
SELECT employee, amount,
       SUM(amount) OVER (
           ORDER BY id
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS running_total
FROM sales;
