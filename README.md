Freight Brokerage Operations Analytics
Overview

This project simulates a freight brokerage analytics environment similar to those used by third-party logistics (3PL). A dimensional data warehouse was designed in MySQL and used to analyze revenue, profitability, shipment performance, and broker productivity across 100,000 freight shipments.

The project demonstrates SQL, data modeling, and Power BI skills commonly required for Data Analyst and Business Analyst roles.

Tools Used
MySQL
SQL
Power BI
DAX
Excel/CSV
Business Problem

Freight brokerages manage thousands of shipments across customers, carriers, and regions. Leadership teams need visibility into:

Revenue and profit performance
Customer industry trends
Shipment delivery performance
Broker productivity
Operational KPIs

This project creates a reporting solution that enables business users to monitor these metrics through an interactive dashboard.

Data Warehouse Design

The project uses a dimensional star schema consisting of:

Fact Table
fact_loads
Dimension Tables
dim_customer
dim_carrier
dim_broker
dim_location
dim_date
Dataset Size
100,000 shipment records
1,500 customers
500 carriers
50 brokers
100 locations
3 years of shipment activity (2023–2025)
Dashboard
Executive Dashboard

The dashboard provides:

Revenue KPIs
Profit KPIs
Shipment volume metrics
Monthly revenue trends
Revenue by customer industry
Shipment status distribution
Top-performing brokers by profit
Key Insights
Revenue by Industry

Manufacturing generated the highest revenue among all customer industries, followed by Retail and Food & Beverage.

Shipment Performance
Approximately 85% of shipments were delivered successfully, while roughly 12% experienced delays.

Broker Performance
Top-performing brokers generated more than $250,000 in annual profit, highlighting significant differences in broker productivity.

Revenue Trends
Revenue remained relatively stable throughout the analysis period, averaging approximately $8 million per month.

Example SQL Analysis
Top Brokers by Profit
SELECT
    b.broker_name,
    SUM(f.profit) AS total_profit
FROM fact_loads f
JOIN dim_broker b
    ON f.broker_id = b.broker_id
GROUP BY b.broker_name
ORDER BY total_profit DESC
LIMIT 10;

Revenue by Industry
SELECT
    c.industry,
    SUM(f.revenue) AS total_revenue
FROM fact_loads f
JOIN dim_customer c
    ON f.customer_id = c.customer_id
GROUP BY c.industry
ORDER BY total_revenue DESC;

Skills Demonstrated
SQL
Joins
Aggregations
GROUP BY
KPI reporting
Business analysis queries
Data Modeling
Star schema design
Fact and dimension tables
Primary and foreign key relationships
Power BI
DAX measures
KPI cards
Line charts
Bar charts
Donut charts
Interactive slicers
Business Analytics
Revenue analysis
Profitability analysis
Operational KPI reporting
Performance benchmarking
