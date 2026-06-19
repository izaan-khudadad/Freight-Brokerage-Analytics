SELECT
    COUNT(*) AS total_loads,
    ROUND(SUM(revenue),2) AS total_revenue,
    ROUND(SUM(profit),2) AS total_profit,
    ROUND(AVG(profit),2) AS avg_profit_per_load
FROM fact_loads;

SELECT
    c.customer_name,
    c.customer_tier,
    ROUND(SUM(f.revenue),2) AS total_revenue
FROM fact_loads f
JOIN dim_customer c
    ON f.customer_id = c.customer_id
GROUP BY c.customer_name, c.customer_tier
ORDER BY total_revenue DESC
LIMIT 10;

SELECT
    c.industry,
    ROUND(SUM(f.revenue),2) AS revenue
FROM fact_loads f
JOIN dim_customer c
    ON f.customer_id = c.customer_id
GROUP BY c.industry
ORDER BY revenue DESC;

SELECT
    c.carrier_tier,
    COUNT(*) AS loads,
    ROUND(AVG(f.delay_days),2) AS avg_delay_days
FROM fact_loads f
JOIN dim_carrier c
    ON f.carrier_id = c.carrier_id
GROUP BY c.carrier_tier;

SELECT
    b.broker_name,
    COUNT(*) AS total_loads,
    ROUND(SUM(f.profit),2) AS total_profit
FROM fact_loads f
JOIN dim_broker b
    ON f.broker_id = b.broker_id
GROUP BY b.broker_name
ORDER BY total_profit DESC
LIMIT 10;

SELECT
    customer_tier,
    COUNT(*) AS loads,
    ROUND(SUM(revenue),2) AS revenue,
    ROUND(AVG(revenue),2) AS avg_load_revenue
FROM fact_loads f
JOIN dim_customer c
    ON f.customer_id = c.customer_id
GROUP BY customer_tier
ORDER BY revenue DESC;

SELECT
    load_status,
    COUNT(*) AS loads,
    ROUND(100.0 * COUNT(*) /
        (SELECT COUNT(*) FROM fact_loads), 2) AS pct_of_total
FROM fact_loads
GROUP BY load_status;

SELECT
    ROUND(AVG(delay_days),2) AS avg_delay_days,
    MAX(delay_days) AS max_delay_days,
    MIN(delay_days) AS min_delay_days
FROM fact_loads
WHERE load_status = 'Delayed';

SELECT
    weather_condition,
    COUNT(*) AS loads,
    ROUND(AVG(delay_days),2) AS avg_delay_days
FROM fact_loads
GROUP BY weather_condition
ORDER BY avg_delay_days DESC;

SELECT
    carrier_tier,
    COUNT(*) AS total_loads,
    ROUND(AVG(delay_days),2) AS avg_delay_days,
    ROUND(AVG(customer_satisfaction_score),2) AS avg_satisfaction,
    ROUND(SUM(profit),2) AS total_profit
FROM fact_loads f
JOIN dim_carrier c
    ON f.carrier_id = c.carrier_id
GROUP BY carrier_tier
ORDER BY total_profit DESC;

SELECT
    broker_name,
    total_profit,
    RANK() OVER (ORDER BY total_profit DESC) AS profit_rank
FROM (
    SELECT
        b.broker_name,
        ROUND(SUM(f.profit),2) AS total_profit
    FROM fact_loads f
    JOIN dim_broker b
        ON f.broker_id = b.broker_id
    GROUP BY b.broker_name
) broker_profit;

SELECT
    d.year,
    d.month,
    ROUND(SUM(f.revenue),2) AS revenue
FROM fact_loads f
JOIN dim_date d
    ON f.pickup_date_id = d.date_id
GROUP BY d.year, d.month
ORDER BY d.year, d.month;

SELECT
    o.city AS origin_city,
    dst.city AS destination_city,
    COUNT(*) AS load_count,
    ROUND(SUM(f.profit),2) AS total_profit
FROM fact_loads f
JOIN dim_location o
    ON f.origin_location_id = o.location_id
JOIN dim_location dst
    ON f.destination_location_id = dst.location_id
GROUP BY o.city, dst.city
ORDER BY total_profit DESC
LIMIT 10;