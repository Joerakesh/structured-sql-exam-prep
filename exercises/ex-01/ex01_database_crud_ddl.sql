-- Ex.No: 1
-- Database/table creation, CRUD, DDL, CTAS, CTE, temporary table, LIKE

CREATE DATABASE IF NOT EXISTS I_MSc_DataScience;
USE I_MSc_DataScience;

CREATE TABLE instagram_records (
    id INT PRIMARY KEY,
    username VARCHAR(100),
    followers_count INT,
    following_count INT,
    posts_count INT
);

-- Insert the Instagram records used in the Classroom exercise.
-- Add the supplied INSERT statements here if you maintain the original classroom dataset.

SELECT * FROM instagram_records ORDER BY followers_count DESC;

ALTER TABLE instagram_records
RENAME COLUMN followers_count TO followers;

-- UPDATE / DELETE examples from the exercise should be practiced on the supplied records.
-- UPDATE instagram_records SET followers = ... WHERE id = ...;
-- DELETE FROM instagram_records WHERE id = ...;

CREATE TABLE music_artists AS
SELECT * FROM instagram_records;

WITH high_m_followers AS (
    SELECT * FROM instagram_records WHERE followers >= 1000000
)
SELECT * FROM high_m_followers;

CREATE TEMPORARY TABLE temp_instagram AS
SELECT * FROM instagram_records;

CREATE TABLE instagram LIKE instagram_records;

-- DDL practice:
-- DELETE FROM instagram_records WHERE ...;
-- TRUNCATE TABLE instagram_records;
-- DROP TABLE instagram;
