# Ex.No 11 - Window Functions

**Script:** [`window_functions.sql`](window_functions.sql)
**Database:** `structured_sql_lab`
**Table:** `sales` (dropped and recreated by the script)

> Run `CREATE DATABASE IF NOT EXISTS structured_sql_lab;` first if needed. This `sales` table is different from the one in `i_msc_datascience` used in Ex.No 5-6.

## Aim
Calculate over a "window" of related rows without collapsing them into one row per group (unlike `GROUP BY`).

## Data

| id | employee | department | amount |
|---|---|---|---|
| 1 | Arun | Data Science | 5000 |
| 2 | Priya | Data Science | 7000 |
| 3 | Rahul | Data Science | 7000 |
| 4 | Divya | IT | 6000 |
| 5 | Kiran | IT | 4000 |

Priya and Rahul are **tied** at 7000, which is what makes the ranking functions differ.

## 1. Ranking: `ROW_NUMBER`, `RANK`, `DENSE_RANK`
`OVER (ORDER BY amount DESC)`

| employee | amount | row_num | rank_num | dense_rank_num |
|---|---|---|---|---|
| Priya | 7000 | 1 | 1 | 1 |
| Rahul | 7000 | 2 | 1 | 1 |
| Divya | 6000 | 3 | 3 | 2 |
| Arun | 5000 | 4 | 4 | 3 |
| Kiran | 4000 | 5 | 5 | 4 |

- `ROW_NUMBER`: always unique (ties broken arbitrarily, so Priya/Rahul may swap).
- `RANK`: ties share a rank and the **next rank is skipped** (1, 1, 3).
- `DENSE_RANK`: ties share a rank and **no rank is skipped** (1, 1, 2).

## 2. Ranking inside each department
`RANK() OVER (PARTITION BY department ORDER BY amount DESC)`

| employee | department | amount | dept_rank |
|---|---|---|---|
| Priya | Data Science | 7000 | 1 |
| Rahul | Data Science | 7000 | 1 |
| Arun | Data Science | 5000 | 3 |
| Divya | IT | 6000 | 1 |
| Kiran | IT | 4000 | 2 |

## 3. `PERCENT_RANK`
Formula: (rank - 1) / (total rows - 1).

| employee | amount | pct_rank |
|---|---|---|
| Kiran | 4000 | 0 |
| Arun | 5000 | 0.25 |
| Divya | 6000 | 0.5 |
| Priya | 7000 | 0.75 |
| Rahul | 7000 | 0.75 |

## 4. `NTILE(2)`: split into 2 buckets
| employee | amount | bucket |
|---|---|---|
| Priya | 7000 | 1 |
| Rahul | 7000 | 1 |
| Divya | 6000 | 1 |
| Arun | 5000 | 2 |
| Kiran | 4000 | 2 |

Five rows into two buckets gives 3 + 2; the extra row goes to the first bucket.

## 5. `LAG` and `LEAD`
`ORDER BY id`

| employee | amount | previous_amount | next_amount |
|---|---|---|---|
| Arun | 5000 | NULL | 7000 |
| Priya | 7000 | 5000 | 7000 |
| Rahul | 7000 | 7000 | 6000 |
| Divya | 6000 | 7000 | 4000 |
| Kiran | 4000 | 6000 | NULL |

## 6. `FIRST_VALUE`, `LAST_VALUE`, `NTH_VALUE`
| employee | amount | highest_sale | lowest_sale | fourth_sale |
|---|---|---|---|---|
| Priya | 7000 | 7000 | 4000 | 5000 |
| Rahul | 7000 | 7000 | 4000 | 5000 |
| Divya | 6000 | 7000 | 4000 | 5000 |
| Arun | 5000 | 7000 | 4000 | 5000 |
| Kiran | 4000 | 7000 | 4000 | 5000 |

`LAST_VALUE` and `NTH_VALUE` need `ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING`. Without it the default frame ends at the current row, so `LAST_VALUE` would just return the current row's own value.

## 7. Aggregates as window functions
`AVG / COUNT / SUM ... OVER (PARTITION BY department)`

| employee | department | amount | dept_avg | dept_count | dept_total |
|---|---|---|---|---|---|
| Arun | Data Science | 5000 | 6333.33 | 3 | 19000 |
| Priya | Data Science | 7000 | 6333.33 | 3 | 19000 |
| Rahul | Data Science | 7000 | 6333.33 | 3 | 19000 |
| Divya | IT | 6000 | 5000 | 2 | 10000 |
| Kiran | IT | 4000 | 5000 | 2 | 10000 |

## 8. Running total
`SUM(amount) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)`

| employee | amount | running_total |
|---|---|---|
| Arun | 5000 | 5000 |
| Priya | 7000 | 12000 |
| Rahul | 7000 | 19000 |
| Divya | 6000 | 25000 |
| Kiran | 4000 | 29000 |

## Exam points
- Window functions keep **every row**; `GROUP BY` collapses rows. Compare query 7 with a plain `GROUP BY department`.
- `PARTITION BY` restarts the calculation for each group; `ORDER BY` defines the order inside the window.
- **Reserved words:** in MySQL 8, `RANK`, `DENSE_RANK`, `PERCENT_RANK`, `ROW_NUMBER` and similar cannot be used as unquoted aliases. The original script used `AS percent_rank`, which caused a syntax error; it is now `AS pct_rank`.
- Window functions require **MySQL 8.0+**.
