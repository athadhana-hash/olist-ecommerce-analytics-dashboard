# Olist E-commerce Analytics Dashboard

## Overview
This project analyzes Olist e-commerce data to evaluate business performance, customer behavior, and operational efficiency.

The objective is to identify key revenue drivers, understand customer satisfaction patterns, and highlight areas for operational improvement using SQL and Power BI.

---

## Tech Stack
- SQL (data cleaning, transformation, aggregation)
- Power BI (data visualization)
- Dataset: Olist E-commerce (Brazil)

---

## Dashboard Preview
![Dashboard](images/dashboard_preview.png)

---

## Business Questions
- What drives revenue growth?
- How does delivery performance affect customer satisfaction?
- Which regions contribute the most to order volume?
- What payment methods dominate transactions?

---

## Data Processing
Data preparation was performed using SQL:
- Standardizing timestamp fields into `order_date`
- Handling missing and inconsistent values
- Joining transactional tables (orders, payments, reviews)
- Creating aggregated metrics (orders, revenue, review score)

---

## Key Metrics
- Total Orders
- Total Revenue
- Cancellation Rate
- Average Review Score
- Average Order Value

---

## Key Insights

- Credit card accounts for the majority of transactions, indicating strong dependency on a single payment channel.

- Revenue growth is primarily driven by increasing order volume rather than higher order value.

- Customer satisfaction is consistently high, with most reviews rated 5 stars.

- Delivery time shows a weak relationship with review score, suggesting other factors (e.g., product quality, expectations) have a stronger impact.

- Order volume is concentrated in a few regions, indicating opportunities for targeted operational and logistical optimization.

---

## Business Implications

- Payment system reliability, especially for credit card processing, is critical to maintaining revenue stability.

- Growth monitoring should distinguish between volume-driven and value-driven performance.

- Operational improvements should focus on high-volume regions to maximize impact.

- Customer experience optimization should not rely solely on delivery speed.

---

## Dashboard Access
The Power BI dashboard file (.pbix) can be accessed here:

[Download Dashboard](PUT_YOUR_LINK_HERE)

---

## Repository Structure
- `/sql` → SQL scripts for data preparation
- `/powerbi` → Power BI dashboard file
- `/images` → Dashboard preview

---

## How to Use
1. Run SQL scripts to prepare the dataset
2. Load the dataset into Power BI
3. Open the `.pbix` file to explore the dashboard
