-- ============================================================
-- PARTITIONING - COMPLETE SQL PRACTICE
-- ============================================================


-- ============================================================
-- 1. CREATE DATABASE
-- ============================================================

CREATE DATABASE partition_db;

USE partition_db;


-- ============================================================
-- 2. CREATE PARTITIONED TABLE
-- ============================================================

CREATE TABLE employees1 (
    emp_id INT NOT NULL,
    emp_name VARCHAR(50) NOT NULL,
    region VARCHAR(20) NOT NULL,

    PRIMARY KEY (emp_id, region)
)

PARTITION BY LIST COLUMNS(region) (

    PARTITION p_asia
    VALUES IN ('India', 'Japan', 'China'),

    PARTITION p_europe
    VALUES IN ('UK', 'Germany', 'France'),

    PARTITION p_americas
    VALUES IN ('USA', 'Canada', 'Brazil')
);


-- ============================================================
-- 3. INSERT DATA
-- ============================================================

INSERT INTO employees1
(emp_id, emp_name, region)
VALUES
(101, 'Arjun Mehta', 'India'),
(102, 'Emma Watson', 'UK'),
(103, 'John Doe', 'USA'),
(104, 'Yuki Tanaka', 'Japan'),
(105, 'Lucas Silva', 'Brazil');


-- ============================================================
-- 4. VIEW ALL DATA
-- ============================================================

SELECT *
FROM employees1;


-- ============================================================
-- 5. EXPLAIN THE QUERY
-- ============================================================

EXPLAIN
SELECT *
FROM employees1;


-- ============================================================
-- 6. EXPLAIN QUERY WITH REGION FILTER
-- ============================================================

EXPLAIN
SELECT *
FROM employees1
WHERE region = 'Brazil';


-- ============================================================
-- 7. QUERY A SPECIFIC REGION
-- ============================================================

SELECT *
FROM employees1
WHERE region = 'Brazil';


-- ============================================================
-- 8. QUERY ASIA REGION
-- ============================================================

SELECT *
FROM employees1
WHERE region = 'India';


-- ============================================================
-- 9. QUERY EUROPE REGION
-- ============================================================

SELECT *
FROM employees1
WHERE region = 'UK';


-- ============================================================
-- 10. QUERY AMERICAS REGION
-- ============================================================

SELECT *
FROM employees1
WHERE region = 'USA';


-- ============================================================
-- 11. SHOW PARTITION INFORMATION
-- ============================================================

SELECT
    TABLE_NAME,
    PARTITION_NAME,
    PARTITION_METHOD,
    PARTITION_EXPRESSION,
    TABLE_ROWS
FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_SCHEMA = 'partition_db'
  AND TABLE_NAME = 'employees1';


-- ============================================================
-- 12. SHOW ONLY PARTITION NAMES
-- ============================================================

SELECT
    PARTITION_NAME
FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_SCHEMA = 'partition_db'
  AND TABLE_NAME = 'employees1';


-- ============================================================
-- 13. INSERT MORE DATA
-- ============================================================

INSERT INTO employees1
(emp_id, emp_name, region)
VALUES
(106, 'Priya Sharma', 'China'),
(107, 'David Miller', 'Germany'),
(108, 'Maria Santos', 'Canada'),
(109, 'Kenji Sato', 'Japan');


-- ============================================================
-- 14. CHECK DATA AGAIN
-- ============================================================

SELECT *
FROM employees1;


-- ============================================================
-- 15. CHECK PARTITION DISTRIBUTION
-- ============================================================

SELECT
    PARTITION_NAME,
    TABLE_ROWS
FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_SCHEMA = 'partition_db'
  AND TABLE_NAME = 'employees1';


-- ============================================================
-- 16. EXPLAIN PARTITION PRUNING
-- ============================================================

EXPLAIN
SELECT *
FROM employees1
WHERE region = 'Brazil';


-- ============================================================
-- 17. DROP TABLE
-- ============================================================

DROP TABLE IF EXISTS employees1;