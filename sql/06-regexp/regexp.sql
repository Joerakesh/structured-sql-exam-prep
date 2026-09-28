USE structured_sql_lab;

DROP TABLE IF EXISTS items;
CREATE TABLE items (
    item_code VARCHAR(30),
    description VARCHAR(100)
);

INSERT INTO items VALUES
('ITEM001', 'apple fruit'),
('ITEM002', 'banana fruit'),
('PROD100', 'orange fruit'),
('ITEMABC', 'mango fruit'),
('ITEM500', 'grape 500');

-- Starts with ITEM
SELECT * FROM items
WHERE item_code REGEXP '^ITEM';

-- Ends with fruit
SELECT * FROM items
WHERE description REGEXP 'fruit$';

-- apple OR banana
SELECT * FROM items
WHERE description REGEXP 'apple|banana';

-- Contains a digit
SELECT * FROM items
WHERE item_code REGEXP '[0-9]';

-- One or more digits
SELECT * FROM items
WHERE item_code REGEXP '[0-9]+';

-- Any single character
SELECT * FROM items
WHERE item_code REGEXP 'ITEM...';

-- Extract first matching number
SELECT item_code,
       REGEXP_SUBSTR(item_code, '[0-9]+') AS number_part
FROM items;

-- Replace numbers with X
SELECT item_code,
       REGEXP_REPLACE(item_code, '[0-9]+', 'X') AS cleaned_code
FROM items;

-- Common pattern operators:
-- ^ start, $ end, | OR, [] character class, + one or more,
-- * zero or more, . any single character.
