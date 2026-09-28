USE structured_sql_lab;

DROP TABLE IF EXISTS employees_list;

-- LIST COLUMNS partitioning
CREATE TABLE employees_list (
    emp_id INT NOT NULL,
    emp_name VARCHAR(50) NOT NULL,
    region VARCHAR(20) NOT NULL,
    PRIMARY KEY (emp_id, region)
)
PARTITION BY LIST COLUMNS(region) (
    PARTITION p_asia VALUES IN ('India', 'Japan', 'China'),
    PARTITION p_europe VALUES IN ('UK', 'Germany', 'France'),
    PARTITION p_americas VALUES IN ('USA', 'Canada', 'Brazil')
);

INSERT INTO employees_list VALUES
(1, 'Arun', 'India'),
(2, 'John', 'UK'),
(3, 'Maria', 'USA'),
(4, 'Ken', 'Japan');

SELECT * FROM employees_list;

EXPLAIN SELECT *
FROM employees_list
WHERE region = 'India';

-- Other partitioning concepts to know for exams:
-- RANGE: divide rows by ranges, commonly dates or numeric values.
-- LIST: divide rows by explicit category values.
-- HASH: distribute rows using a hash expression.
-- KEY: MySQL chooses the hashing method for key columns.

-- Important: table partitioning PARTITION BY is different from
-- PARTITION BY inside a window function.
