# Ex.No 10 - Partition

**Script:** [`partition.sql`](partition.sql)
**Database:** `structured_sql_lab`
**Table:** `employees_list` (partitioned by `LIST COLUMNS`)

> This exercise was added for exam preparation (it is not one of the Classroom postings). Run `CREATE DATABASE IF NOT EXISTS structured_sql_lab;` first if needed.

## Aim
Split one large table into smaller physical pieces (partitions) so MySQL can read only the partitions a query needs ("partition pruning").

## The table
```sql
CREATE TABLE employees_list (
    emp_id INT NOT NULL,
    emp_name VARCHAR(50) NOT NULL,
    region VARCHAR(20) NOT NULL,
    PRIMARY KEY (emp_id, region)
)
PARTITION BY LIST COLUMNS(region) (
    PARTITION p_asia     VALUES IN ('India', 'Japan', 'China'),
    PARTITION p_europe   VALUES IN ('UK', 'Germany', 'France'),
    PARTITION p_americas VALUES IN ('USA', 'Canada', 'Brazil')
);
```

| Partition | Regions |
|---|---|
| `p_asia` | India, Japan, China |
| `p_europe` | UK, Germany, France |
| `p_americas` | USA, Canada, Brazil |

## Data and where it lands

| emp_id | emp_name | region | Partition |
|---|---|---|---|
| 1 | Arun | India | p_asia |
| 2 | John | UK | p_europe |
| 3 | Maria | USA | p_americas |
| 4 | Ken | Japan | p_asia |

`SELECT *` returns rows grouped by partition (Arun, Ken, John, Maria), not in insert order.

## Proving partition pruning
```sql
EXPLAIN SELECT * FROM employees_list WHERE region = 'India';
```
The `partitions` column of the output shows **`p_asia`** only, meaning MySQL skipped the other two partitions.

## Types of partitioning

| Type | Rows are divided by | Typical use |
|---|---|---|
| `RANGE` | Ranges of a value | Dates or numeric ranges (year, salary band) |
| `LIST` | An explicit list of values | Categories such as region or department (used here) |
| `HASH` | A hash of an expression | Even distribution across N partitions |
| `KEY` | Hash of column(s), function chosen by MySQL | Like `HASH`, but MySQL picks the hashing |

Reference syntax (not in the script):
```sql
-- RANGE
PARTITION BY RANGE (YEAR(order_date)) (
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p2026 VALUES LESS THAN (2027),
    PARTITION pmax  VALUES LESS THAN MAXVALUE
);
-- HASH
PARTITION BY HASH(emp_id) PARTITIONS 4;
```

## Exam points
- **The primary key must include the partitioning column.** That is why the key is `(emp_id, region)` and not just `emp_id`.
- Inserting a value that belongs to no partition (for example `'Australia'`) fails with an error, because no partition exists for it.
- **Table partitioning is not the same as `PARTITION BY` inside a window function** (Ex.No 11). One physically splits storage; the other only groups rows for a calculation.
- Partitioning helps large tables where queries filter on the partition column; it does not speed up queries that ignore it.
