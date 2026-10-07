# SQL Cohort Retention Analysis

A customer retention analysis using SQL and the UCI Online Retail dataset.

## Objective

Measure monthly customer retention by grouping customers according to the month of their first purchase.

## Dataset

- 541,909 transactions
- UK online retailer
- December 2010 – December 2011
- 4,338 customers after cleaning

## Tools

- PostgreSQL
- SQL
- Window functions
- CTEs
- CASE expressions
- Power BI / Tableau

## Analysis

The project:

1. Cleans transaction data
2. Identifies each customer's first purchase month
3. Creates customer-month activity
4. Calculates months since acquisition
5. Calculates cohort retention %
6. Produces a cohort retention matrix
7. Visualizes retention as a heatmap

## Key findings

- Average month-1 retention was approximately 23.7%
- Retention varied considerably between acquisition cohorts
- The first cohort is affected by the dataset's December 2010 start date
- The final December 2011 cohort is incomplete because the dataset ends on December 9

## SQL
See [`sql/cohort_retention.sql`](sql/cohort_retention.sql).

## Article
Read the full explanation on Medium: 