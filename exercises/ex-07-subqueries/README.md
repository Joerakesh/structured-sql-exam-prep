# Ex.No 7 - Subqueries

**Script:** [`subqueries.sql`](subqueries.sql)
**Database:** `structured_sql_lab`
**Tables:** `departments`, `employees` (created and filled by the script)

> The script runs `USE structured_sql_lab` but does not create that database (Ex.No 8 does). If it does not exist yet, run `CREATE DATABASE IF NOT EXISTS structured_sql_lab;` first.

## Aim
Use queries nested inside other queries: `IN`, `EXISTS`, `NOT EXISTS`, correlated, scalar, `ANY` and `ALL` subqueries.

## Data

**departments**

| dept_id | dept_name |
|---|---|
| 10 | Data Science |
| 20 | IT |
| 30 | HR |

**employees**

| emp_id | emp_name | dept_id | salary |
|---|---|---|---|
| 1 | Arun | 10 | 70000 |
| 2 | Priya | 10 | 85000 |
| 3 | Rahul | 20 | 60000 |
| 4 | Divya | 30 | 50000 |

## Queries and expected output

| # | Type | Question | Result |
|---|---|---|---|
| 1 | `IN` | Employees in the Data Science or IT departments | Arun, Priya, Rahul |
| 2 | `EXISTS` (correlated) | Employees whose department exists in `departments` | Arun, Priya, Rahul, Divya |
| 3 | `NOT EXISTS` | Employees with **no** matching department | *(empty set)* |
| 4 | Correlated | Employees earning more than their **own department's** average | Priya (85000) |
| 5 | Scalar | Employees earning more than the **overall** average (66250) | Arun, Priya |
| 6 | `ANY` | Salary greater than **at least one** Data Science salary (i.e. > 70000) | Priya |
| 7 | `ALL` | Salary greater than **every** HR salary (i.e. > 50000) | Arun, Priya, Rahul |

## How each type works
- **`IN`**: the inner query runs once and returns a list; the outer query keeps rows whose value is in it.
- **`EXISTS`**: for each outer row, checks whether the inner query returns at least one row. `SELECT 1` is a convention, since only existence matters.
- **Correlated subquery**: the inner query refers to the outer row (`e2.dept_id = e.dept_id`), so it is evaluated once per outer row. Department averages are 77500 (Data Science), 60000 (IT) and 50000 (HR); only Priya is above her own average.
- **Scalar subquery**: returns exactly one value, so it can be used with `>`, `=` and so on.
- **`> ANY`** is equivalent to `> MIN(...)`; **`> ALL`** is equivalent to `> MAX(...)`.

## Exam points
- Query 3 returns nothing because every employee has a valid department. Insert an employee with `dept_id = 99` to see it return a row.
- A scalar subquery that returns more than one row causes an error.
- `NOT IN` behaves unexpectedly when the subquery returns `NULL`; `NOT EXISTS` does not have that problem.
