USE structured_sql_lab;

DROP TABLE IF EXISTS index_demo;

CREATE TABLE index_demo (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    department VARCHAR(50),
    city VARCHAR(50),
    email VARCHAR(150),
    cgpa DECIMAL(4,2)
);

INSERT INTO index_demo VALUES
(1, 'Arun', 'Data Science', 'Chennai', 'arun@example.com', 9.1),
(2, 'Priya', 'Data Science', 'Bengaluru', 'priya@example.com', 8.7),
(3, 'Rahul', 'IT', 'Chennai', 'rahul@example.com', 8.2),
(4, 'Divya', 'HR', 'Mumbai', 'divya@example.com', 9.0);

-- Query before adding an email index
EXPLAIN SELECT *
FROM index_demo
WHERE email = 'arun@example.com';

-- Single-column index
CREATE INDEX idx_email
ON index_demo(email);

EXPLAIN SELECT *
FROM index_demo
WHERE email = 'arun@example.com';

-- Composite index: useful when queries commonly filter by
-- department and then city.
CREATE INDEX idx_department_city
ON index_demo(department, city);

EXPLAIN SELECT *
FROM index_demo
WHERE department = 'Data Science'
  AND city = 'Chennai';

SHOW INDEX FROM index_demo;

-- Indexes improve lookup performance but add storage and
-- write/update/delete maintenance cost.
