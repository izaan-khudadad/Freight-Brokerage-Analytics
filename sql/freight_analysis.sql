USE freight_analytics;

-- ==========================
-- DIMENSION TABLES
-- ==========================

CREATE TABLE dim_customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    industry VARCHAR(50),
    customer_tier VARCHAR(20),
    region VARCHAR(20),
    customer_since DATE
);

CREATE TABLE dim_carrier (
    carrier_id INT PRIMARY KEY,
    carrier_name VARCHAR(100),
    carrier_tier VARCHAR(20),
    carrier_type VARCHAR(20),
    fleet_size INT,
    safety_score DECIMAL(5,2),
    home_region VARCHAR(20)
);

CREATE TABLE dim_broker (
    broker_id INT PRIMARY KEY,
    broker_name VARCHAR(100),
    hire_date DATE,
    team VARCHAR(20)
);

CREATE TABLE dim_location (
    location_id INT PRIMARY KEY,
    city VARCHAR(50),
    state CHAR(2),
    region VARCHAR(20)
);

CREATE TABLE dim_date (
    date_id INT PRIMARY KEY,
    full_date DATE,
    year INT,
    quarter INT,
    month INT,
    month_name VARCHAR(20),
    week INT,
    day_of_week VARCHAR(20)
);

-- ==========================
-- FACT TABLE
-- ==========================

CREATE TABLE fact_loads (
    load_id BIGINT PRIMARY KEY,

    customer_id INT,
    carrier_id INT,
    broker_id INT,

    pickup_date_id INT,
    delivery_date_id INT,

    origin_location_id INT,
    destination_location_id INT,

    equipment_type VARCHAR(20),
    miles INT,
    weight_lbs INT,

    weather_condition VARCHAR(20),
    load_status VARCHAR(20),
    delay_days INT,

    revenue DECIMAL(10,2),
    carrier_cost DECIMAL(10,2),
    fuel_surcharge DECIMAL(10,2),
    profit DECIMAL(10,2),

    customer_satisfaction_score DECIMAL(3,1),

    CONSTRAINT fk_customer
        FOREIGN KEY (customer_id)
        REFERENCES dim_customer(customer_id),

    CONSTRAINT fk_carrier
        FOREIGN KEY (carrier_id)
        REFERENCES dim_carrier(carrier_id),

    CONSTRAINT fk_broker
        FOREIGN KEY (broker_id)
        REFERENCES dim_broker(broker_id),

    CONSTRAINT fk_pickup_date
        FOREIGN KEY (pickup_date_id)
        REFERENCES dim_date(date_id),

    CONSTRAINT fk_delivery_date
        FOREIGN KEY (delivery_date_id)
        REFERENCES dim_date(date_id),

    CONSTRAINT fk_origin
        FOREIGN KEY (origin_location_id)
        REFERENCES dim_location(location_id),

    CONSTRAINT fk_destination
        FOREIGN KEY (destination_location_id)
        REFERENCES dim_location(location_id)
);

SELECT 'dim_customer' AS table_name, COUNT(*) AS row_count
FROM dim_customer

UNION ALL

SELECT 'dim_carrier', COUNT(*)
FROM dim_carrier

UNION ALL

SELECT 'dim_broker', COUNT(*)
FROM dim_broker

UNION ALL

SELECT 'dim_location', COUNT(*)
FROM dim_location

UNION ALL

SELECT 'dim_date', COUNT(*)
FROM dim_date;

SELECT COUNT(*)
FROM fact_loads;

SELECT
COUNT(*) AS total_loads,
ROUND(SUM(revenue),2) AS total_revenue,
ROUND(SUM(profit),2) AS total_profit
FROM fact_loads;

