# Olist E-commerce Analytics Dashboard

## Overview
This project analyzes Olist e-commerce data to evaluate business performance, customer behavior, and operational efficiency. The analysis pipeline starts from SQL-based data preparation and ends with an interactive Power BI dashboard.

## Tech Stack
- SQL (data cleaning, transformation, aggregation)
- Power BI (data visualization)
- Dataset: Olist E-commerce (Brazil)

## Dashboard Preview
![Dashboard](images/dashboard_preview.png)

## Dashboard File

The Power BI dashboard file (.pbix) can be accessed here:
[Download Dashboard](https://drive.google.com/drive/folders/1GbQM3j1PzO_54XRSujah3ja-xqCTsZtb?usp=drive_link)

## Data Processing
Data preparation was performed using SQL:
- Standardizing timestamp fields into `order_date`
- Handling missing and inconsistent values
- Creating aggregated metrics (monthly orders, revenue, review score)
- Joining transactional tables (orders, payments, reviews)

## Key Metrics
- Total Orders
- Total Revenue
- Cancellation Rate
- Average Review Score
- Average Order Value

## Key Findings
- Credit card dominates as the primary payment method
- Revenue and order volume show a consistent upward trend over time
- Customer satisfaction is generally high (majority 5-star reviews)
- Delivery time does not strongly impact review score

## Repository Structure
- `/sql` contains all data transformation scripts
- `/powerbi` contains the dashboard file
- `/images` contains visual assets

## How to Use
1. Execute SQL scripts to prepare the dataset
2. Load the dataset into Power BI
3. Open the `.pbix` file to explore the dashboard

## Key Insights

- Credit card is the dominant payment method, accounting for the majority of transactions. The business is highly dependent on this channel.

- Orders and revenue show consistent growth over time, indicating stable business expansion. The decline in the final period is likely due to incomplete data.

- Customer satisfaction is generally high, with most reviews rated 5 stars.

- Delivery time shows a weak relationship with review scores, suggesting other factors (e.g., product quality, expectations) influence satisfaction more strongly.

- Order volume is concentrated in a few key regions, indicating opportunities for targeted operational and marketing optimization.
