-- ============================================================
-- NORMALIZATION - COMPLETE SQL PRACTICE
-- ============================================================

CREATE DATABASE normalization_db;

USE normalization_db;


-- ============================================================
-- 1. UNNORMALIZED FORM (UNF)
-- ============================================================
-- Problem:
-- Multiple courses are stored inside one column.

CREATE TABLE student_unf (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    courses VARCHAR(200)
);

INSERT INTO student_unf VALUES
(1, 'Alice', 'Python, SQL, MongoDB'),
(2, 'Bob', 'Python, Machine Learning'),
(3, 'Carol', 'SQL, Statistics');

SELECT * FROM student_unf;


-- ============================================================
-- 2. FIRST NORMAL FORM (1NF)
-- ============================================================
-- Rule:
-- Each column must contain atomic values.
-- One cell = one value.
--
-- We separate multiple courses into individual rows.

CREATE TABLE student_1nf (
    student_id INT,
    student_name VARCHAR(100),
    course VARCHAR(100),

    PRIMARY KEY (student_id, course)
);

INSERT INTO student_1nf VALUES
(1, 'Alice', 'Python'),
(1, 'Alice', 'SQL'),
(1, 'Alice', 'MongoDB'),
(2, 'Bob', 'Python'),
(2, 'Bob', 'Machine Learning'),
(3, 'Carol', 'SQL'),
(3, 'Carol', 'Statistics');

SELECT * FROM student_1nf;


-- ============================================================
-- 3. SECOND NORMAL FORM (2NF)
-- ============================================================
-- Rule:
-- Must be in 1NF
-- AND
-- No partial dependency.
--
-- Composite key:
-- (student_id, course_id)
--
-- Problem:
-- student_name depends only on student_id.
-- course_name depends only on course_id.
--
-- Therefore, they are partial dependencies.


CREATE TABLE student_course_bad (
    student_id INT,
    student_name VARCHAR(100),
    course_id INT,
    course_name VARCHAR(100),
    marks INT,

    PRIMARY KEY (student_id, course_id)
);

INSERT INTO student_course_bad VALUES
(1, 'Alice', 101, 'Python', 90),
(1, 'Alice', 102, 'SQL', 85),
(2, 'Bob', 101, 'Python', 88),
(2, 'Bob', 103, 'MongoDB', 92);

SELECT * FROM student_course_bad;


-- ============================================================
-- 4. CONVERT TO 2NF
-- ============================================================
-- Separate student information.

CREATE TABLE students_2nf (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100)
);

INSERT INTO students_2nf VALUES
(1, 'Alice'),
(2, 'Bob');


-- Separate course information.

CREATE TABLE courses_2nf (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100)
);

INSERT INTO courses_2nf VALUES
(101, 'Python'),
(102, 'SQL'),
(103, 'MongoDB');


-- Keep only the relationship and dependent data.

CREATE TABLE student_courses_2nf (
    student_id INT,
    course_id INT,
    marks INT,

    PRIMARY KEY (student_id, course_id),

    FOREIGN KEY (student_id)
        REFERENCES students_2nf(student_id),

    FOREIGN KEY (course_id)
        REFERENCES courses_2nf(course_id)
);

INSERT INTO student_courses_2nf VALUES
(1, 101, 90),
(1, 102, 85),
(2, 101, 88),
(2, 103, 92);

SELECT * FROM students_2nf;

SELECT * FROM courses_2nf;

SELECT * FROM student_courses_2nf;


-- ============================================================
-- 5. THIRD NORMAL FORM (3NF)
-- ============================================================
-- Rule:
-- Must be in 2NF
-- AND
-- No transitive dependency.
--
-- Example:
--
-- student_id -> dept_id
-- dept_id -> dept_name
--
-- Therefore:
--
-- student_id -> dept_id -> dept_name
--
-- dept_name depends indirectly on student_id.


CREATE TABLE student_3nf_bad (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    dept_id INT,
    dept_name VARCHAR(100)
);

INSERT INTO student_3nf_bad VALUES
(1, 'Alice', 10, 'Data Science'),
(2, 'Bob', 10, 'Data Science'),
(3, 'Carol', 20, 'Computer Science');

SELECT * FROM student_3nf_bad;


-- ============================================================
-- 6. CONVERT TO 3NF
-- ============================================================

CREATE TABLE departments_3nf (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100)
);

INSERT INTO departments_3nf VALUES
(10, 'Data Science'),
(20, 'Computer Science');


CREATE TABLE students_3nf (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    dept_id INT,

    FOREIGN KEY (dept_id)
        REFERENCES departments_3nf(dept_id)
);

INSERT INTO students_3nf VALUES
(1, 'Alice', 10),
(2, 'Bob', 10),
(3, 'Carol', 20);

SELECT * FROM departments_3nf;

SELECT * FROM students_3nf;


-- ============================================================
-- 7. JOIN THE 3NF TABLES
-- ============================================================

SELECT
    s.student_id,
    s.student_name,
    d.dept_name
FROM students_3nf s
JOIN departments_3nf d
    ON s.dept_id = d.dept_id;


-- ============================================================
-- 8. BCNF
-- ============================================================
-- BCNF rule:
-- Every determinant must be a candidate key.
--
-- Example:
--
-- Student -> Advisor
-- Advisor -> Department
--
-- If Advisor determines Department but Advisor is not
-- a candidate key of the original relationship,
-- the table violates BCNF.


CREATE TABLE student_advisor_bad (
    student_id INT,
    advisor VARCHAR(100),
    department VARCHAR(100),

    PRIMARY KEY (student_id, advisor)
);

INSERT INTO student_advisor_bad VALUES
(1, 'Dr. Kumar', 'Data Science'),
(2, 'Dr. Kumar', 'Data Science'),
(3, 'Dr. Priya', 'Computer Science');

SELECT * FROM student_advisor_bad;


-- Decompose into separate tables.

CREATE TABLE advisors (
    advisor_id INT PRIMARY KEY,
    advisor_name VARCHAR(100),
    department VARCHAR(100)
);

INSERT INTO advisors VALUES
(1, 'Dr. Kumar', 'Data Science'),
(2, 'Dr. Priya', 'Computer Science');


CREATE TABLE student_advisors (
    student_id INT,
    advisor_id INT,

    PRIMARY KEY (student_id, advisor_id),

    FOREIGN KEY (advisor_id)
        REFERENCES advisors(advisor_id)
);

INSERT INTO student_advisors VALUES
(1, 1),
(2, 1),
(3, 2);

SELECT * FROM advisors;

SELECT * FROM student_advisors;


-- ============================================================
-- 9. FOURTH NORMAL FORM (4NF)
-- ============================================================
-- Rule:
-- No independent multivalued dependencies.
--
-- Problem:
-- A student can have multiple skills
-- AND
-- a student can have multiple hobbies.
--
-- Skills and hobbies are independent facts.


CREATE TABLE student_skills_hobbies_bad (
    student_id INT,
    skill VARCHAR(100),
    hobby VARCHAR(100)
);

INSERT INTO student_skills_hobbies_bad VALUES
(1, 'Python', 'Cricket'),
(1, 'Python', 'Music'),
(1, 'SQL', 'Cricket'),
(1, 'SQL', 'Music');

SELECT * FROM student_skills_hobbies_bad;


-- ============================================================
-- 10. CONVERT TO 4NF
-- ============================================================

CREATE TABLE student_skills (
    student_id INT,
    skill VARCHAR(100),

    PRIMARY KEY (student_id, skill)
);

INSERT INTO student_skills VALUES
(1, 'Python'),
(1, 'SQL');


CREATE TABLE student_hobbies (
    student_id INT,
    hobby VARCHAR(100),

    PRIMARY KEY (student_id, hobby)
);

INSERT INTO student_hobbies VALUES
(1, 'Cricket'),
(1, 'Music');


SELECT * FROM student_skills;

SELECT * FROM student_hobbies;


-- ============================================================
-- 11. FIFTH NORMAL FORM (5NF)
-- ============================================================
-- 5NF deals with JOIN dependencies.
--
-- A complex many-to-many relationship can sometimes
-- be decomposed into smaller relationships.


CREATE TABLE student_course_teacher_bad (
    student_id INT,
    course_id INT,
    teacher_id INT
);

INSERT INTO student_course_teacher_bad VALUES
(1, 101, 201),
(1, 102, 202),
(2, 101, 201);

SELECT * FROM student_course_teacher_bad;


-- Decompose into smaller relationships.


CREATE TABLE student_course (
    student_id INT,
    course_id INT,

    PRIMARY KEY (student_id, course_id)
);

INSERT INTO student_course VALUES
(1, 101),
(1, 102),
(2, 101);


CREATE TABLE course_teacher (
    course_id INT,
    teacher_id INT,

    PRIMARY KEY (course_id, teacher_id)
);

INSERT INTO course_teacher VALUES
(101, 201),
(102, 202);


CREATE TABLE student_teacher (
    student_id INT,
    teacher_id INT,

    PRIMARY KEY (student_id, teacher_id)
);

INSERT INTO student_teacher VALUES
(1, 201),
(1, 202),
(2, 201);


SELECT * FROM student_course;

SELECT * FROM course_teacher;

SELECT * FROM student_teacher;