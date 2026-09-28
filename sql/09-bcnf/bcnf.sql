USE structured_sql_lab;

/*
BCNF THEORY

For every functional dependency X -> Y in a relation,
X must be a superkey.

Example relation:
StudentCourse(student_id, course_id, instructor)

Functional dependencies:
1. (student_id, course_id) -> instructor
2. instructor -> course_id

Candidate key: (student_id, course_id)

The dependency instructor -> course_id violates BCNF because
instructor is not a superkey of StudentCourse.
*/

DROP TABLE IF EXISTS student_instructor;
DROP TABLE IF EXISTS instructor_course;
DROP TABLE IF EXISTS student_course_bcnf;

-- Original relation containing the BCNF violation
CREATE TABLE student_course_bcnf (
    student_id INT,
    course_id INT,
    instructor VARCHAR(50),
    PRIMARY KEY (student_id, course_id)
);

INSERT INTO student_course_bcnf
(student_id, course_id, instructor)
VALUES
(1, 101, 'John'),
(2, 101, 'John'),
(3, 102, 'Alice'),
(4, 102, 'Alice'),
(5, 103, 'David');

SELECT * FROM student_course_bcnf;

-- BCNF violation:
-- instructor -> course_id
-- instructor is NOT a superkey.

-- Decomposition step 1: instructor determines course
CREATE TABLE instructor_course (
    instructor VARCHAR(50) PRIMARY KEY,
    course_id INT NOT NULL
);

INSERT INTO instructor_course (instructor, course_id)
VALUES
('John', 101),
('Alice', 102),
('David', 103);

-- Decomposition step 2: student is associated with instructor
CREATE TABLE student_instructor (
    student_id INT,
    instructor VARCHAR(50),
    PRIMARY KEY (student_id, instructor),
    FOREIGN KEY (instructor)
        REFERENCES instructor_course(instructor)
);

INSERT INTO student_instructor (student_id, instructor)
VALUES
(1, 'John'),
(2, 'John'),
(3, 'Alice'),
(4, 'Alice'),
(5, 'David');

SELECT * FROM instructor_course;
SELECT * FROM student_instructor;

-- Reconstruct the original information with a JOIN
SELECT
    si.student_id,
    ic.course_id,
    si.instructor
FROM student_instructor si
JOIN instructor_course ic
    ON si.instructor = ic.instructor;

/*
BCNF exam workflow:
1. Write the relation.
2. Identify functional dependencies.
3. Find candidate/superkeys.
4. Check every FD: determinant must be a superkey.
5. If an FD violates BCNF, decompose the relation.
6. Verify the decomposed tables and reconstruct with JOIN.
*/
