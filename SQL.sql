DROP TABLE bookings;

CREATE TABLE bookings (
    hotel TEXT,
    is_canceled INT,
    lead_time INT,
    arrival_date_year INT,
    arrival_date_month TEXT,
    arrival_date_week_number INT,
    arrival_date_day_of_month INT,
    stays_in_weekend_nights INT,
    stays_in_week_nights INT,
    adults INT,
    children FLOAT,
    babies INT,
    meal TEXT,
    country TEXT,
    market_segment TEXT,
    distribution_channel TEXT,
    is_repeated_guest INT,
    previous_cancellations INT,
    previous_bookings_not_canceled INT,
    reserved_room_type TEXT,
    assigned_room_type TEXT,
    booking_changes INT,
    deposit_type TEXT,
    agent FLOAT,
    days_in_waiting_list INT,
    customer_type TEXT,
    adr FLOAT,
    required_car_parking_spaces INT,
    total_of_special_requests INT,
    reservation_status TEXT,
    reservation_status_date DATE,
    total_guests FLOAT,
    total_nights INT,
    revenue FLOAT,
    arrival_date DATE,
    stay_type TEXT,
    lead_category TEXT
);




SET datestyle TO 'DMY';

COPY bookings
FROM 'C:/Users/Dipendra/Desktop/Hotel Revenue Optimization & Performance Dashboard/CSV Dataset/cleaned_hotel_data.csv'
DELIMITER ','
CSV HEADER
NULL '';

SELECT COUNT(*) FROM bookings;


SELECT SUM(revenue) AS total_revenue
FROM bookings;

SELECT COUNT(*) AS total_bookings
FROM bookings;

SELECT 
    COUNT(*) FILTER (WHERE is_canceled = 0) * 100.0 / COUNT(*) AS occupancy_rate
FROM bookings;

SELECT 
    COUNT(*) FILTER (WHERE is_canceled = 1) * 100.0 / COUNT(*) AS cancellation_rate
FROM bookings;


SELECT 
    SUM(revenue) / SUM(total_nights) AS adr
FROM bookings;

SELECT 
    SUM(revenue) / COUNT(*) AS revpar
FROM bookings;


SELECT 
    hotel,
    SUM(revenue) AS total_revenue
FROM bookings
GROUP BY hotel
ORDER BY total_revenue DESC;


SELECT 
    lead_category,
    COUNT(*) FILTER (WHERE is_canceled = 1) * 100.0 / COUNT(*) AS cancellation_rate
FROM bookings
GROUP BY lead_category;



SELECT 
    market_segment,
    SUM(revenue) AS revenue
FROM bookings
GROUP BY market_segment
ORDER BY revenue DESC;


SELECT 
    DATE_TRUNC('month', arrival_date) AS month,
    SUM(revenue) AS total_revenue
FROM bookings
GROUP BY month
ORDER BY month;



SELECT 
    hotel,
    COUNT(*) FILTER (WHERE is_canceled = 0) * 100.0 / COUNT(*) AS occupancy_rate
FROM bookings
GROUP BY hotel;


SELECT 
    hotel,
    SUM(revenue)/SUM(total_nights) AS adr,
    COUNT(*) FILTER (WHERE is_canceled = 0) * 100.0 / COUNT(*) AS occupancy_rate
FROM bookings
GROUP BY hotel;


SELECT 
    stay_type,
    SUM(revenue) AS revenue,
    COUNT(*) AS bookings
FROM bookings
GROUP BY stay_type;


SELECT 
    country,
    SUM(revenue) AS revenue
FROM bookings
GROUP BY country
ORDER BY revenue DESC
LIMIT 10;


SELECT 
    lead_category,
    COUNT(*) FILTER (WHERE is_canceled = 1) * 100.0 / COUNT(*) AS cancellation_rate
FROM bookings
GROUP BY lead_category
ORDER BY cancellation_rate DESC;



CREATE VIEW kpi_summary AS
SELECT 
    COUNT(*) AS total_bookings,
    SUM(revenue) AS total_revenue,
    SUM(revenue)/SUM(total_nights) AS adr,
    SUM(revenue)/COUNT(*) AS revpar,
    COUNT(*) FILTER (WHERE is_canceled = 1) * 100.0 / COUNT(*) AS cancellation_rate
FROM bookings;



CREATE OR REPLACE VIEW kpi_summary AS
SELECT 
    COUNT(*) AS total_bookings,
    SUM(revenue) AS total_revenue,
    SUM(revenue)/SUM(total_nights) AS adr,
    SUM(revenue)/COUNT(*) AS revpar,
    COUNT(*) FILTER (WHERE is_canceled = 1) * 100.0 / COUNT(*) AS cancellation_rate,
    COUNT(*) FILTER (WHERE is_canceled = 0) * 100.0 / COUNT(*) AS occupancy_rate
FROM bookings;



CREATE OR REPLACE VIEW dashboard_data AS
SELECT 
    hotel,
    arrival_date,
    market_segment,
    customer_type,
    stay_type,
    lead_category,
    country,
    revenue,
    total_nights,
    is_canceled
FROM bookings;


