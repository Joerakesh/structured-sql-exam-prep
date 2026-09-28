-- Ex.No: 5 - Aggregate Functions

USE i_msc_datascience;

CREATE TABLE IF NOT EXISTS sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    region VARCHAR(50) NOT NULL,
    category VARCHAR(50) NOT NULL,
    amount DECIMAL(10, 2) DEFAULT NULL,
    sale_date DATE NOT NULL
);

-- Classroom data
INSERT INTO sales (region, category, amount, sale_date) VALUES
('North', 'Electronics', 1500.00, '2026-01-10'),
('South', 'Electronics', 800.00, '2026-01-12'),
('North', 'Furniture', 400.00, '2026-01-15'),
('North', 'Electronics', 1200.00, '2026-01-18'),
('South', 'Furniture', 600.00, '2026-01-20'),
('South', 'Furniture', NULL, '2026-01-22');

SELECT * FROM sales;

SELECT
    COUNT(*) AS total_rows,
    COUNT(amount) AS valid_sales_count,
    SUM(amount) AS total_revenue,
    AVG(amount) AS average_sale,
    MIN(amount) AS lowest_sale,
    MAX(amount) AS highest_sale
FROM sales;
