USE structured_sql_lab;

/*
NORMALISATION PROGRESSION

UNF -> 1NF -> 2NF -> 3NF -> BCNF

1NF: atomic values; no repeating groups.
2NF: 1NF + no partial dependency on part of a composite key.
3NF: 2NF + no problematic transitive dependency.
BCNF: for every functional dependency X -> Y, X must be a superkey.
*/

-- 1NF example: keep one course per row instead of a repeating group.
DROP TABLE IF EXISTS student_courses_1nf;
CREATE TABLE student_courses_1nf (
    student_id INT,
    student_name VARCHAR(50),
    course_id INT,
    course_name VARCHAR(100),
    PRIMARY KEY (student_id, course_id)
);

INSERT INTO student_courses_1nf VALUES
(1, 'Arun', 101, 'SQL'),
(1, 'Arun', 102, 'MongoDB'),
(2, 'Priya', 101, 'SQL');

-- 2NF: remove attributes depending only on part of a composite key.
DROP TABLE IF EXISTS student_course_2nf;
CREATE TABLE student_course_2nf (
    student_id INT,
    course_id INT,
    marks INT,
    PRIMARY KEY (student_id, course_id)
);

-- student details belong in a separate student table.
DROP TABLE IF EXISTS students_2nf;
CREATE TABLE students_2nf (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50)
);

-- 3NF: remove transitive dependency.
-- Example: student_id -> zip_code -> city.
DROP TABLE IF EXISTS students_3nf;
DROP TABLE IF EXISTS zip_locations;

CREATE TABLE zip_locations (
    zip_code VARCHAR(10) PRIMARY KEY,
    city VARCHAR(50) NOT NULL
);

CREATE TABLE students_3nf (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    zip_code VARCHAR(10),
    FOREIGN KEY (zip_code) REFERENCES zip_locations(zip_code)
);

INSERT INTO zip_locations VALUES
('600034', 'Chennai'),
('560001', 'Bengaluru');

INSERT INTO students_3nf VALUES
(1, 'Arun', '600034'),
(2, 'Priya', '560001');

SELECT s.student_id, s.student_name, s.zip_code, z.city
FROM students_3nf s
JOIN zip_locations z ON s.zip_code = z.zip_code;

-- Candidate key example:
-- In student_course_2nf, (student_id, course_id) is a candidate key.
-- Both attributes are required to identify one student-course record.
