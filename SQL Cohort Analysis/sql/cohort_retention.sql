-- Cohort retention on the UCI Online Retail dataset (DuckDB / PostgreSQL-style syntax)

WITH orders AS (
    SELECT
        CAST(CustomerID AS BIGINT)                          AS customer_id,
        InvoiceNo                                           AS order_id,
        strptime(InvoiceDate, '%m/%d/%Y %H:%M')             AS order_date,
        Quantity * UnitPrice                                AS order_amount
    FROM raw_sales
    WHERE CustomerID IS NOT NULL              -- 24.9% of rows have no customer
      AND InvoiceNo NOT LIKE 'C%'             -- cancellations
      AND Quantity  > 0
      AND UnitPrice > 0                       -- zero/negative prices (the 'A' bad-debt rows have no customer ID, so the first filter removes them)
),

customer_cohorts AS (
    SELECT customer_id, DATE_TRUNC('month', MIN(order_date)) AS cohort_month
    FROM orders
    GROUP BY customer_id
),

customer_activity AS (
    SELECT DISTINCT customer_id, DATE_TRUNC('month', order_date) AS activity_month
    FROM orders
),

cohort_activity AS (
    SELECT
        a.customer_id,
        c.cohort_month,
        (EXTRACT(YEAR  FROM a.activity_month) - EXTRACT(YEAR  FROM c.cohort_month)) * 12
      + (EXTRACT(MONTH FROM a.activity_month) - EXTRACT(MONTH FROM c.cohort_month)) AS month_number
    FROM customer_activity a
    JOIN customer_cohorts c USING (customer_id)
),

cohort_counts AS (
    SELECT cohort_month, month_number, COUNT(DISTINCT customer_id) AS active_customers
    FROM cohort_activity
    GROUP BY cohort_month, month_number
),

retention AS (
    SELECT
        cohort_month, month_number, active_customers,
        ROUND(100.0 * active_customers
              / MAX(CASE WHEN month_number = 0 THEN active_customers END)
                    OVER (PARTITION BY cohort_month), 1) AS retention_pct
    FROM cohort_counts
)

SELECT
    cohort_month,
    MAX(CASE WHEN month_number = 0 THEN active_customers END) AS cohort_size,
    MAX(CASE WHEN month_number = 1 THEN retention_pct END) AS m1,
    MAX(CASE WHEN month_number = 2 THEN retention_pct END) AS m2,
    MAX(CASE WHEN month_number = 3 THEN retention_pct END) AS m3,
    MAX(CASE WHEN month_number = 6 THEN retention_pct END) AS m6,
    MAX(CASE WHEN month_number = 11 THEN retention_pct END) AS m11
FROM retention
GROUP BY cohort_month
ORDER BY cohort_month;
