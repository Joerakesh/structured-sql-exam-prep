# Ex.No 9 - REGEXP

**Script:** [`regexp.sql`](regexp.sql)
**Database:** `structured_sql_lab`
**Table:** `items` (created and filled by the script)

> Run `CREATE DATABASE IF NOT EXISTS structured_sql_lab;` first if it does not exist (Ex.No 8 creates it).

## Aim
Match, extract and replace text using regular expressions in MySQL 8.

## Data

| item_code | description |
|---|---|
| ITEM001 | apple fruit |
| ITEM002 | banana fruit |
| PROD100 | orange fruit |
| ITEMABC | mango fruit |
| ITEM500 | grape 500 |

## Pattern operators

| Symbol | Meaning |
|---|---|
| `^` | Start of the string |
| `$` | End of the string |
| `\|` | OR |
| `[ ]` | Character class, e.g. `[0-9]` is any digit |
| `+` | One or more of the previous item |
| `*` | Zero or more of the previous item |
| `.` | Any single character |

## Queries and expected output

| # | Query condition | Rows returned |
|---|---|---|
| 1 | `item_code REGEXP '^ITEM'` (starts with ITEM) | ITEM001, ITEM002, ITEMABC, ITEM500 |
| 2 | `description REGEXP 'fruit$'` (ends with fruit) | ITEM001, ITEM002, PROD100, ITEMABC |
| 3 | `description REGEXP 'apple\|banana'` | ITEM001, ITEM002 |
| 4 | `item_code REGEXP '[0-9]'` (contains a digit) | ITEM001, ITEM002, PROD100, ITEM500 |
| 5 | `item_code REGEXP '[0-9]+'` (one or more digits) | ITEM001, ITEM002, PROD100, ITEM500 |
| 6 | `item_code REGEXP 'ITEM...'` (ITEM + any 3 characters) | ITEM001, ITEM002, ITEMABC, ITEM500 |

### 7. `REGEXP_SUBSTR`: extract the first number
| item_code | number_part |
|---|---|
| ITEM001 | 001 |
| ITEM002 | 002 |
| PROD100 | 100 |
| ITEMABC | NULL |
| ITEM500 | 500 |

### 8. `REGEXP_REPLACE`: replace numbers with `X`
| item_code | cleaned_code |
|---|---|
| ITEM001 | ITEMX |
| ITEM002 | ITEMX |
| PROD100 | PRODX |
| ITEMABC | ITEMABC |
| ITEM500 | ITEMX |

`[0-9]+` replaces the whole run of digits with a single `X`, which is why `001` becomes one `X` rather than three.

## Exam points
- `REGEXP` matches **anywhere** in the string unless anchored with `^` or `$`. That is why `'[0-9]'` and `'[0-9]+'` give the same rows.
- `REGEXP_SUBSTR` returns `NULL` when nothing matches (ITEMABC).
- `RLIKE` is a synonym for `REGEXP`; use `NOT REGEXP` to negate.
- Matching is case-insensitive with the default collation; use `REGEXP_LIKE(col, pattern, 'c')` for case-sensitive matching.
- `LIKE` uses `%` and `_` wildcards and must match the whole value; `REGEXP` is far more flexible.
