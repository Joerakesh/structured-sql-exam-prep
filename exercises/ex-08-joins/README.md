# Ex.No 8 - JOIN

**Script:** [`joins.sql`](joins.sql)
**Database:** `structured_sql_lab` (created by this script)
**Tables:** `restaurants`, `orders1`

## Aim
Combine rows from related tables using `INNER`, `LEFT`, `RIGHT`, self and (simulated) full outer joins.

## Data

**restaurants**

| id | name | location |
|---|---|---|
| 1 | Cafe A | Chennai |
| 2 | Cafe B | Bengaluru |
| 3 | Cafe C | Chennai |
| 4 | Cafe D | Mumbai |

**orders1**

| order_id | restaurant_id | order_date | amount |
|---|---|---|---|
| 101 | 1 | 2026-09-01 | 450 |
| 102 | 1 | 2026-09-02 | 300 |
| 103 | 2 | 2026-09-03 | 700 |
| 104 | 3 | 2026-09-04 | 250 |

Cafe D has **no orders**, which makes the difference between the join types visible.

## Queries and expected output

### 1. INNER JOIN: only matching rows
| restaurant_name | order_date | amount |
|---|---|---|
| Cafe A | 2026-09-01 | 450.00 |
| Cafe A | 2026-09-02 | 300.00 |
| Cafe B | 2026-09-03 | 700.00 |
| Cafe C | 2026-09-04 | 250.00 |

### 2. LEFT JOIN: every restaurant, with or without orders
| restaurant_name | order_id |
|---|---|
| Cafe A | 101 |
| Cafe A | 102 |
| Cafe B | 103 |
| Cafe C | 104 |
| Cafe D | NULL |

### 3. RIGHT JOIN: every order, with or without a restaurant
Same four rows as the inner join, because every order has a matching restaurant.

### 4. Join with a filter (`amount > 300`)
| name | location | order_id | amount |
|---|---|---|---|
| Cafe A | Chennai | 101 | 450.00 |
| Cafe B | Bengaluru | 103 | 700.00 |

Order 102 (exactly 300) is excluded because the condition is strictly greater than.

### 5. SELF JOIN: restaurants in the same location
| restaurant1 | restaurant2 | location |
|---|---|---|
| Cafe A | Cafe C | Chennai |

`r1.id < r2.id` stops a restaurant pairing with itself and prevents the same pair appearing twice (A-C and C-A).

### 6. FULL OUTER JOIN (simulated)
MySQL has no `FULL OUTER JOIN`, so the script uses `LEFT JOIN ... UNION ... RIGHT JOIN`.

| id | name | order_id |
|---|---|---|
| 1 | Cafe A | 101 |
| 1 | Cafe A | 102 |
| 2 | Cafe B | 103 |
| 3 | Cafe C | 104 |
| 4 | Cafe D | NULL |

## Exam points
- `LEFT JOIN` keeps all rows from the left table; unmatched right-side columns become `NULL`.
- `UNION` removes duplicate rows; `UNION ALL` keeps them. The full outer join emulation relies on `UNION` to remove the rows both sides produce.
- Query 4 is labelled "multi-table" in the script but joins only two tables. A true three-table join chains another `JOIN ... ON ...`.
- Find "unmatched" rows with `LEFT JOIN ... WHERE o.order_id IS NULL` (here: Cafe D).
- Row order in join output is not guaranteed without `ORDER BY`.
