# Ex.No 2 - String Functions

**Script:** [`ex02_string_functions.sql`](ex02_string_functions.sql)
**Table used:** `luxury_clothing` (from the Classroom exercise)

## Aim
Practise MySQL's built-in string functions on the columns of the `luxury_clothing` table.

## Important
The script currently holds **only comments**: the list of functions to practise. The classroom `CREATE TABLE luxury_clothing` and its `INSERT` statements are not in the repository. Paste them into the script (above the function practice), then apply each function below to the relevant column, such as brand, product name or category.

## Functions covered

| Function | Purpose | Example | Result |
|---|---|---|---|
| `LENGTH(str)` | Number of bytes in the string | `LENGTH('Gucci')` | `5` |
| `UPPER(str)` | Converts to upper case | `UPPER('gucci')` | `GUCCI` |
| `CONCAT(a, b, ...)` | Joins strings together | `CONCAT('Gucci',' ','Bag')` | `Gucci Bag` |
| `SUBSTRING(str, pos, len)` | Extracts part of a string (positions start at 1) | `SUBSTRING('Louis Vuitton',1,5)` | `Louis` |
| `LPAD(str, len, pad)` | Pads on the left to a fixed length | `LPAD('42',5,'0')` | `00042` |
| `REPLACE(str, from, to)` | Replaces every occurrence of a substring | `REPLACE('red silk','red','blue')` | `blue silk` |
| `ASCII(char)` | ASCII code of the first character | `ASCII('A')` | `65` |
| `TRIM(str)` | Removes leading and trailing spaces | `TRIM('  hi  ')` | `hi` |
| `OCT(n)` | Number converted to octal | `OCT(10)` | `12` |
| `BIN(n)` | Number converted to binary | `BIN(10)` | `1010` |
| `STRCMP(a, b)` | `-1` if a < b, `0` if equal, `1` if a > b | `STRCMP('a','b')` | `-1` |

The examples above were run on MySQL 8.0 and use literal values, so they work without any table.

## Template once the table is loaded
```sql
SELECT brand,
       LENGTH(brand)        AS name_length,
       UPPER(brand)         AS brand_upper,
       CONCAT(brand, ' - ', category) AS label
FROM luxury_clothing;
```
Replace `brand` and `category` with your actual column names.

## Exam points
- `LENGTH()` counts **bytes**; use `CHAR_LENGTH()` for characters (they differ for non-ASCII text).
- `SUBSTRING` positions start at **1**, not 0.
- `TRIM` removes spaces only at the ends, never inside the string.
- `STRCMP` compares using the column's collation, so it is usually case-insensitive.
