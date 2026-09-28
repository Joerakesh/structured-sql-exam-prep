CREATE DATABASE IF NOT EXISTS structured_sql_lab;
USE structured_sql_lab;

DROP TABLE IF EXISTS orders1;
DROP TABLE IF EXISTS restaurants;
DROP TABLE IF EXISTS employees;

CREATE TABLE restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    location VARCHAR(100)
);

CREATE TABLE orders1 (
    order_id INT PRIMARY KEY,
    restaurant_id INT,
    order_date DATE,
    amount DECIMAL(10,2)
);

INSERT INTO restaurants VALUES
(1, 'Cafe A', 'Chennai'),
(2, 'Cafe B', 'Bengaluru'),
(3, 'Cafe C', 'Chennai'),
(4, 'Cafe D', 'Mumbai');

INSERT INTO orders1 VALUES
(101, 1, '2026-09-01', 450),
(102, 1, '2026-09-02', 300),
(103, 2, '2026-09-03', 700),
(104, 3, '2026-09-04', 250);

-- 1. INNER JOIN
SELECT r.name AS restaurant_name, o.order_date, o.amount
FROM restaurants r
INNER JOIN orders1 o ON r.id = o.restaurant_id;

-- 2. LEFT JOIN
SELECT r.name AS restaurant_name, o.order_id
FROM restaurants r
LEFT JOIN orders1 o ON r.id = o.restaurant_id;

-- 3. RIGHT JOIN
SELECT r.name AS restaurant_name, o.order_id
FROM restaurants r
RIGHT JOIN orders1 o ON r.id = o.restaurant_id;

-- 4. MULTI-TABLE JOIN
SELECT r.name, r.location, o.order_id, o.amount
FROM restaurants r
JOIN orders1 o ON r.id = o.restaurant_id
WHERE o.amount > 300;

-- 5. SELF JOIN: restaurants in the same location
SELECT r1.name AS restaurant1, r2.name AS restaurant2, r1.location
FROM restaurants r1
JOIN restaurants r2
  ON r1.location = r2.location
 AND r1.id < r2.id;

-- 6. FULL OUTER JOIN concept in MySQL.
-- MySQL does not provide FULL OUTER JOIN directly.
-- LEFT JOIN + RIGHT JOIN + UNION gives the equivalent result for this case.
SELECT r.id, r.name, o.order_id
FROM restaurants r
LEFT JOIN orders1 o ON r.id = o.restaurant_id
UNION
SELECT r.id, r.name, o.order_id
FROM restaurants r
RIGHT JOIN orders1 o ON r.id = o.restaurant_id;
