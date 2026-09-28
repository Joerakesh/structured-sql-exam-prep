# Ex.No 1 - Database, CRUD, DDL, CTAS, CTE, Temporary Table, LIKE

**Script:** [`ex01_database_crud_ddl.sql`](ex01_database_crud_ddl.sql)
**Database created:** `I_MSc_DataScience`
**Table used:** `instagram_records`

## Aim
Create a database and a table, run basic CRUD operations, and learn the different ways of copying or structuring tables: `CTAS`, `CTE`, `TEMPORARY TABLE` and `CREATE TABLE ... LIKE`.

## Setup
The script creates the table but the classroom `INSERT` statements are **not included**. Add your supplied records after the `CREATE TABLE`, or use this sample to test:

```sql
INSERT INTO instagram_records VALUES
(1,'cristiano',600000000,560,3800),
(2,'selenagomez',420000000,300,2000),
(3,'arrahman',5000000,80,900),
(4,'localband',25000,400,150);
```

## Concepts covered

| Concept | Statement in the script | What it does |
|---|---|---|
| Create database | `CREATE DATABASE IF NOT EXISTS ...; USE ...;` | Creates the database only if missing, then selects it |
| Create table | `CREATE TABLE instagram_records (...)` | Defines columns, data types and the `PRIMARY KEY` |
| Read (R) | `SELECT * ... ORDER BY followers_count DESC` | Lists rows, most followers first |
| Alter column name | `ALTER TABLE ... RENAME COLUMN followers_count TO followers` | Renames a column (**MySQL 8.0+ only**) |
| Update / Delete (U, D) | `UPDATE ... SET ... WHERE ...` / `DELETE FROM ... WHERE ...` | Left as commented templates; fill in with your classroom values |
| CTAS | `CREATE TABLE music_artists AS SELECT * FROM instagram_records` | Creates a new table **with the data** copied |
| CTE | `WITH high_m_followers AS (...) SELECT ...` | A named temporary result that exists only for that one query |
| Temporary table | `CREATE TEMPORARY TABLE temp_instagram AS ...` | Table visible only to your session; dropped automatically on disconnect |
| `CREATE TABLE ... LIKE` | `CREATE TABLE instagram LIKE instagram_records` | Copies the **structure only** (no rows) |

## Expected output (with the sample data above)

Query 1, before the rename:

| id | username | followers_count | following_count | posts_count |
|---|---|---|---|---|
| 1 | cristiano | 600000000 | 560 | 3800 |
| 2 | selenagomez | 420000000 | 300 | 2000 |
| 3 | arrahman | 5000000 | 80 | 900 |
| 4 | localband | 25000 | 400 | 150 |

CTE `high_m_followers` (followers >= 1,000,000), after the rename:

| id | username | followers | following_count | posts_count |
|---|---|---|---|---|
| 1 | cristiano | 600000000 | 560 | 3800 |
| 2 | selenagomez | 420000000 | 300 | 2000 |
| 3 | arrahman | 5000000 | 80 | 900 |

`SELECT COUNT(*) FROM instagram;` returns `0`, because `LIKE` copies structure only.

## Exam points
- **Order matters:** the first `SELECT` uses `followers_count`; the CTE uses `followers`. After the `RENAME COLUMN`, the old name no longer works.
- **CTAS vs LIKE:** CTAS copies data but not keys or indexes (the `id` column in `music_artists` is no longer a primary key). `LIKE` copies structure and indexes but no data.
- **DDL vs DML:** `CREATE`, `ALTER`, `DROP`, `TRUNCATE` are DDL. `INSERT`, `UPDATE`, `DELETE`, `SELECT` are DML/DQL.
- **DELETE vs TRUNCATE vs DROP:** `DELETE` removes chosen rows and can use `WHERE`; `TRUNCATE` empties the whole table and resets `AUTO_INCREMENT`; `DROP` removes the table itself.
- **CTE vs temporary table:** a CTE lives for one statement; a temporary table lives for the whole session.

## How to run
```bash
mysql -u root -p < ex01_database_crud_ddl.sql
```
or open the file in MySQL Workbench and press the lightning-bolt button.
