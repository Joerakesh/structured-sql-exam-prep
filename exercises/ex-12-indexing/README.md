# Ex.No 12 - Indexing

**Script:** [`indexing.sql`](indexing.sql)
**Database:** `structured_sql_lab`
**Table:** `index_demo` (dropped and recreated by the script)

> Run `CREATE DATABASE IF NOT EXISTS structured_sql_lab;` first if needed.

## Aim
See how an index changes the way MySQL finds rows, using `EXPLAIN` before and after creating single-column and composite indexes.

## Data

| student_id | student_name | department | city | email | cgpa |
|---|---|---|---|---|---|
| 1 | Arun | Data Science | Chennai | arun@example.com | 9.10 |
| 2 | Priya | Data Science | Bengaluru | priya@example.com | 8.70 |
| 3 | Rahul | IT | Chennai | rahul@example.com | 8.20 |
| 4 | Divya | HR | Mumbai | divya@example.com | 9.00 |

`student_id` is the `PRIMARY KEY`, so it is indexed automatically.

## Steps and what `EXPLAIN` shows

### 1. Before any index
```sql
EXPLAIN SELECT * FROM index_demo WHERE email = 'arun@example.com';
```
`type = ALL`, `key = NULL`, `rows = 4`: a **full table scan**, reading every row.

### 2. After a single-column index
```sql
CREATE INDEX idx_email ON index_demo(email);
```
Running the same `EXPLAIN` now shows `type = ref`, `key = idx_email`, `rows = 1`: MySQL jumps straight to the matching row.

### 3. Composite index
```sql
CREATE INDEX idx_department_city ON index_demo(department, city);
EXPLAIN SELECT * FROM index_demo WHERE department = 'Data Science' AND city = 'Chennai';
```
Shows `key = idx_department_city` and `ref = const,const`: both columns are used to locate the row.

### 4. List the indexes
```sql
SHOW INDEX FROM index_demo;
```

| Key_name | Seq_in_index | Column_name | Non_unique |
|---|---|---|---|
| PRIMARY | 1 | student_id | 0 |
| idx_email | 1 | email | 1 |
| idx_department_city | 1 | department | 1 |
| idx_department_city | 2 | city | 1 |

## Reading `EXPLAIN`

| Column | Meaning |
|---|---|
| `type` | How rows are accessed: `ALL` (full scan) is worst; `ref`, `const` are index lookups |
| `possible_keys` | Indexes MySQL could use |
| `key` | Index actually chosen |
| `rows` | Estimated rows to examine |

## Exam points
- **Composite index order matters (leftmost-prefix rule):** `(department, city)` helps queries filtering on `department` or on `department AND city`, but generally not on `city` alone.
- Indexes speed up reads but cost **extra storage** and slow down `INSERT`, `UPDATE` and `DELETE`, since the index must be maintained.
- Good candidates: columns used in `WHERE`, `JOIN` and `ORDER BY`. Poor candidates: tiny tables and low-selectivity columns.
- `UNIQUE INDEX` enforces uniqueness as well as speeding lookups; a primary key is a unique index that cannot be `NULL`.
- Drop an index with `DROP INDEX idx_email ON index_demo;`.
- On a table this small, MySQL may still choose a full scan even when an index exists; the demo is about the concept, and differences show on large tables.
