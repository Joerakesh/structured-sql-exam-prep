-- Ex.No: 6 - GROUP BY, HAVING, Statistics, CASE

USE i_msc_datascience;

-- Run Ex.No: 5 first to create/populate sales, or use the same Classroom setup.

SELECT
    region,
    COUNT(sale_id) AS total_orders,
    SUM(amount) AS region_revenue,
    ROUND(AVG(amount), 2) AS avg_order_value
FROM sales
GROUP BY region;

SELECT
    category,
    COUNT(DISTINCT region) AS distinct_regions,
    SUM(amount) AS category_revenue
FROM sales
GROUP BY category
HAVING category_revenue > 1000;

-- WHERE + IN / NOT IN
SELECT COUNT(*) FROM sales
WHERE category IN ('Electronics', 'Furniture');

SELECT COUNT(*) FROM sales
WHERE category NOT IN ('Electronics');

-- Statistical functions
SELECT
    AVG(amount) AS avg_amount,
    STD(amount) AS stddev,
    VARIANCE(amount) AS vn
FROM sales;

-- CASE WHEN
SELECT
    sale_id,
    region,
    amount,
    CASE
        WHEN amount >= 1200 THEN 'High Value'
        WHEN amount >= 600 THEN 'Medium Value'
        WHEN amount IS NULL THEN 'No Sale / Returned'
        ELSE 'Low Value'
    END AS sale_category
FROM sales;

-- Classroom note: population standard deviation example gives 400.00
-- for the five non-NULL sales: 1500, 800, 400, 1200, 600.
