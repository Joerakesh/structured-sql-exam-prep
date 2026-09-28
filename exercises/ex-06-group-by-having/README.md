# Ex.No 6 - GROUP BY, HAVING, Statistics, CASE

**Script:** [`ex06_group_by_having_statistics_case.sql`](ex06_group_by_having_statistics_case.sql)
**Database:** `i_msc_datascience`
**Table:** `sales` (run [Ex.No 5](../ex-05-aggregate-functions/) first)

## Aim
Group rows and filter the groups (`GROUP BY`, `HAVING`), filter with `IN` / `NOT IN`, use statistical functions (`STD`, `VARIANCE`), and label rows with `CASE WHEN`.

## Queries and expected output

### 1. Orders and revenue per region
```sql
SELECT region, COUNT(sale_id) AS total_orders, SUM(amount) AS region_revenue,
       ROUND(AVG(amount), 2) AS avg_order_value
FROM sales GROUP BY region;
```

| region | total_orders | region_revenue | avg_order_value |
|---|---|---|---|
| North | 3 | 3100.00 | 1033.33 |
| South | 3 | 1400.00 | 700.00 |

South has 3 orders, but the average uses only the 2 non-NULL amounts (800 and 600).

### 2. Categories with revenue above 1000 (`HAVING`)
```sql
SELECT category, COUNT(DISTINCT region) AS distinct_regions, SUM(amount) AS category_revenue
FROM sales GROUP BY category HAVING category_revenue > 1000;
```

| category | distinct_regions | category_revenue |
|---|---|---|
| Electronics | 2 | 3500.00 |

Furniture totals exactly 1000.00, and `> 1000` is false, so it is excluded.

### 3. `IN` and `NOT IN`
```sql
SELECT COUNT(*) FROM sales WHERE category IN ('Electronics', 'Furniture');   -- 6
SELECT COUNT(*) FROM sales WHERE category NOT IN ('Electronics');            -- 3
```

### 4. Statistical functions
```sql
SELECT AVG(amount) AS avg_amount, STD(amount) AS stddev, VARIANCE(amount) AS vn FROM sales;
```

| avg_amount | stddev | vn |
|---|---|---|
| 900.000000 | 400 | 160000 |

`STD` and `VARIANCE` are the **population** versions (divide by n = 5). The sample versions are `STDDEV_SAMP` and `VAR_SAMP` (divide by n - 1). The classroom answer of 400 matches the population standard deviation.

### 5. `CASE WHEN` classification
```sql
CASE WHEN amount >= 1200 THEN 'High Value'
     WHEN amount >= 600  THEN 'Medium Value'
     WHEN amount IS NULL THEN 'No Sale / Returned'
     ELSE 'Low Value' END AS sale_category
```

| sale_id | region | amount | sale_category |
|---|---|---|---|
| 1 | North | 1500.00 | High Value |
| 2 | South | 800.00 | Medium Value |
| 3 | North | 400.00 | Low Value |
| 4 | North | 1200.00 | High Value |
| 5 | South | 600.00 | Medium Value |
| 6 | South | NULL | No Sale / Returned |

## Exam points
- **WHERE vs HAVING:** `WHERE` filters rows *before* grouping; `HAVING` filters groups *after* aggregation.
- `CASE` checks conditions **top to bottom** and stops at the first match, so order the ranges from highest to lowest.
- A `NULL` never satisfies `amount >= 600`, so the `IS NULL` branch is reached; it is still good practice to test `NULL` first.
- If the list contains `NULL`, `NOT IN` returns no rows at all; be careful with it in subqueries.
