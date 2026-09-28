# Ex.No 5 - Aggregate Functions

**Script:** [`ex05_aggregate_functions.sql`](ex05_aggregate_functions.sql)
**Database:** `i_msc_datascience`
**Table:** `sales` (created and filled by the script)

> Ex.No 5 and 6 were posted together in Classroom (`Ex.No: 5, Ex.No:6`). Run this exercise first; Ex.No 6 reuses the `sales` table.

## Aim
Summarise a table with the aggregate functions `COUNT`, `SUM`, `AVG`, `MIN` and `MAX`, and see how they treat `NULL`.

## Data

| sale_id | region | category | amount | sale_date |
|---|---|---|---|---|
| 1 | North | Electronics | 1500.00 | 2026-01-10 |
| 2 | South | Electronics | 800.00 | 2026-01-12 |
| 3 | North | Furniture | 400.00 | 2026-01-15 |
| 4 | North | Electronics | 1200.00 | 2026-01-18 |
| 5 | South | Furniture | 600.00 | 2026-01-20 |
| 6 | South | Furniture | NULL | 2026-01-22 |

Row 6 deliberately has a `NULL` amount (a sale with no value recorded).

## Query
```sql
SELECT
    COUNT(*)      AS total_rows,
    COUNT(amount) AS valid_sales_count,
    SUM(amount)   AS total_revenue,
    AVG(amount)   AS average_sale,
    MIN(amount)   AS lowest_sale,
    MAX(amount)   AS highest_sale
FROM sales;
```

## Expected output

| total_rows | valid_sales_count | total_revenue | average_sale | lowest_sale | highest_sale |
|---|---|---|---|---|---|
| 6 | 5 | 4500.00 | 900.000000 | 400.00 | 1500.00 |

## Why these numbers
- `COUNT(*)` counts **all rows** (6), including the row with `NULL`.
- `COUNT(amount)` counts only **non-NULL** values (5).
- `SUM`, `AVG`, `MIN` and `MAX` **ignore `NULL`**: the average is 4500 / 5 = 900, not 4500 / 6 = 750.

## Exam points
- `COUNT(*)` vs `COUNT(column)` vs `COUNT(DISTINCT column)` is a favourite question.
- If every value is `NULL`, `SUM`, `AVG`, `MIN` and `MAX` return `NULL`, while `COUNT(column)` returns `0`.
- Use `COALESCE(amount, 0)` if you want `NULL` treated as zero (the average then becomes 750).

## How to run
```bash
mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS i_msc_datascience"
mysql -u root -p < ex05_aggregate_functions.sql
```
