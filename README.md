# Structured SQL Exam Preparation

A practical, exam-oriented **MySQL study repository** for **I M.Sc. Data Science**.

This repository contains SQL concepts, examples, and practical queries prepared for structured-data examination practice.

The `cia-2` branch contains the current exam preparation material, organized topic-by-topic for easy revision.

---

## 📚 Exam Topics

| #   | Topic            | SQL File                                       |
| --- | ---------------- | ---------------------------------------------- |
| 1   | JOINs            | `sql/01-joins/joins.sql`                       |
| 2   | Subqueries       | `sql/02-subqueries/subqueries.sql`             |
| 3   | Normalisation    | `sql/03-normalisation/normalisation.sql`       |
| 4   | Views            | `sql/04-views/views.sql`                       |
| 5   | Indexing         | `sql/05-indexing/indexing.sql`                 |
| 6   | REGEXP           | `sql/06-regexp/regexp.sql`                     |
| 7   | Partitioning     | `sql/07-partition/partition.sql`               |
| 8   | Window Functions | `sql/08-window-functions/window_functions.sql` |
| 9   | BCNF             | `sql/09-bcnf/bcnf.sql`                         |

---

# 🗂️ Repository Structure

```text
structured-sql-exam-prep/
│
├── README.md
│
├── exercises/
│   │
│   ├── ex-07-subqueries/
│   ├── ex-08-joins/
│   ├── ex-09-regexp/
│   ├── ex-10-partition/
│   ├── ex-11-window-functions/
│   ├── ex-12-indexing/
│   ├── ex-13-views/
│   └── ex-14-norm/
│
├── sql/
│   │
│   ├── 01-joins/
│   │   └── joins.sql
│   │
│   ├── 02-subqueries/
│   │   └── subqueries.sql
│   │
│   ├── 03-normalisation/
│   │   └── normalisation.sql
│   │
│   ├── 04-views/
│   │   └── views.sql
│   │
│   ├── 05-indexing/
│   │   └── indexing.sql
│   │
│   ├── 06-regexp/
│   │   └── regexp.sql
│   │
│   ├── 07-partition/
│   │   └── partition.sql
│   │
│   ├── 08-window-functions/
│   │   └── window_functions.sql
│   │
│   └── 09-bcnf/
│       └── bcnf.sql
│
└── ...
```

---

# 1. JOINs

File:

```text
sql/01-joins/joins.sql
```

Topics covered:

- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- Multi-table JOIN
- SELF JOIN
- FULL OUTER JOIN concept using `LEFT JOIN + RIGHT JOIN + UNION`
- `JOIN ... ON`
- JOIN with `WHERE`

Example concepts use `restaurants` and `orders1` tables.

---

# 2. Subqueries

File:

```text
sql/02-subqueries/subqueries.sql
```

Topics covered:

- `IN` subquery
- `EXISTS`
- `NOT EXISTS`
- Correlated subquery
- Scalar subquery
- `ANY`
- `ALL`

Examples use `employees` and `departments`.

---

# 3. Normalisation

File:

```text
sql/03-normalisation/normalisation.sql
```

Normalization progression:

```text
UNF
 ↓
1NF
 ↓
2NF
 ↓
3NF
 ↓
BCNF
```

Topics covered:

### 1NF

- Atomic values
- No repeating groups
- One course per row

### 2NF

- 1NF
- No partial dependency
- Composite key
- Candidate key

### 3NF

- 2NF
- Removal of transitive dependency
- Foreign-key based decomposition

---

# 4. Views

File:

```text
sql/04-views/views.sql
```

Topics covered:

- `CREATE VIEW`
- Simple View
- View using `WHERE`
- View using `JOIN`
- Querying a View
- Updating a simple View
- `SHOW FULL TABLES`
- `DROP VIEW`
- View updateability concepts

Example views:

```text
high_earners
employee_department_info
```

---

# 5. Indexing

File:

```text
sql/05-indexing/indexing.sql
```

Topics covered:

- Primary key index
- Single-column index
- Composite index
- `CREATE INDEX`
- `EXPLAIN`
- `SHOW INDEX`
- Query performance
- Index read-performance benefits
- Index storage and write-maintenance cost

Example indexes:

```sql
CREATE INDEX idx_email
ON index_demo(email);
```

```sql
CREATE INDEX idx_department_city
ON index_demo(department, city);
```

---

# 6. REGEXP

File:

```text
sql/06-regexp/regexp.sql
```

Topics covered:

- `REGEXP`
- `^` — starts with
- `$` — ends with
- `|` — OR
- `[]` — character class
- `+` — one or more
- `*` — zero or more
- `.` — any single character
- `REGEXP_SUBSTR()`
- `REGEXP_REPLACE()`

Example:

```sql
SELECT *
FROM items
WHERE item_code REGEXP '^ITEM';
```

---

# 7. Partitioning

File:

```text
sql/07-partition/partition.sql
```

Current practical example:

```text
LIST COLUMNS Partitioning
```

The example partitions employees according to region:

```text
p_asia
├── India
├── Japan
└── China

p_europe
├── UK
├── Germany
└── France

p_americas
├── USA
├── Canada
└── Brazil
```

Also includes concepts to know for exams:

- RANGE partitioning
- LIST partitioning
- HASH partitioning
- KEY partitioning
- `EXPLAIN`
- Partition pruning concept

> Note: Table partitioning with `PARTITION BY` is different from `PARTITION BY` used inside a window function.

---

# 8. Window Functions

File:

```text
sql/08-window-functions/window_functions.sql
```

Topics covered:

### Ranking

- `ROW_NUMBER()`
- `RANK()`
- `DENSE_RANK()`

### Advanced ranking

- `PERCENT_RANK()`
- `NTILE()`

### Row navigation

- `LAG()`
- `LEAD()`

### Value functions

- `FIRST_VALUE()`
- `LAST_VALUE()`
- `NTH_VALUE()`

### Window aggregates

- `SUM()`
- `AVG()`
- `COUNT()`

### Other concepts

- `PARTITION BY`
- `ORDER BY`
- Window frames
- Running total
- Department-wise ranking
- Department-wise aggregate values

---

# 9. BCNF

File:

```text
sql/09-bcnf/bcnf.sql
```

BCNF means:

> For every functional dependency `X → Y`, `X` must be a superkey.

Exam workflow:

```text
1. Write the relation
       ↓
2. Identify functional dependencies
       ↓
3. Find candidate/superkeys
       ↓
4. Check every dependency
       ↓
5. Identify BCNF violation
       ↓
6. Decompose the relation
       ↓
7. Verify using JOIN
```

The practical example demonstrates:

```text
Student
Course
Instructor
```

and decomposes a relation with:

```text
instructor → course_id
```

when `instructor` is not a superkey.

---

# 🧠 Quick Revision

```text
JOIN
→ Combine data from multiple tables

SUBQUERY
→ Query inside another query

NORMALISATION
→ Organize data and reduce redundancy

VIEW
→ Saved SQL query behaving like a virtual table

INDEX
→ Improve data lookup performance

REGEXP
→ Pattern matching in text

PARTITION
→ Divide a large table into smaller logical partitions

WINDOW FUNCTION
→ Calculate across related rows without collapsing them

BCNF
→ Every determinant must be a superkey
```

---

# 📝 Exam Revision Order

Recommended study sequence:

```text
01. JOINs
       ↓
02. Subqueries
       ↓
03. Normalisation
       ↓
04. Views
       ↓
05. Indexing
       ↓
06. REGEXP
       ↓
07. Partition
       ↓
08. Window Functions
       ↓
09. BCNF
```

For each topic:

```text
Understand the concept
        ↓
Understand the table structure
        ↓
Run CREATE TABLE
        ↓
Insert sample data
        ↓
Run basic query
        ↓
Understand the output
        ↓
Practice variations
```

---
