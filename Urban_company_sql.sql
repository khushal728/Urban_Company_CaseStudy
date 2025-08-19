SET datestyle = 'MDY';
DROP TABLE IF EXISTS UC_reviews;
CREATE TABLE UC_reviews (
    Date DATE,
    time VARCHAR(20),
    ratings INTEGER,
    review_title TEXT,
    review_comment TEXT
);

CREATE TABLE services (
    service_id SERIAL PRIMARY KEY,
    service VARCHAR(100),
    subservice_name VARCHAR(255),
    subservice_charge TEXT,
    city_name VARCHAR(100),
    country_name VARCHAR(100),
    source VARCHAR(100)
);

CREATE VIEW urban_summary AS
SELECT 
    r.date,
    r.time,
    r.ratings,
    r.review_title,
    r.review_comment,
    s.service,
    s.subservice_name,
    s.subservice_charge,
    s.city_name,
    s.country_name,
    s.source
FROM UC_reviews r
JOIN services s ON r.review_title = s.subservice_name;  -- adjust JOIN condition based on real key


SELECT 
    service,
    subservice_name,
    COUNT(*) AS total_reviews,
    ROUND(AVG(ratings), 2) AS avg_rating
FROM urban_summary
GROUP BY service, subservice_name;

SELECT 
    DATE_TRUNC('month', date) AS month,
    ROUND(AVG(ratings), 2) AS avg_monthly_rating,
    COUNT(*) AS total_reviews
FROM urban_summary
GROUP BY month
ORDER BY month;


SELECT 
    city_name,
    SUM(subservice_charge) AS estimated_revenue,
    COUNT(*) AS total_services
FROM urban_summary
GROUP BY city_name
ORDER BY estimated_revenue DESC;

SELECT 
    source,
    COUNT(*) AS review_count,
    ROUND(AVG(ratings), 2) AS avg_rating
FROM urban_summary
GROUP BY source;


SELECT *
FROM uc_reviews r
JOIN services s ON r.review_title ILIKE '%' || s.subservice_name || '%'
LIMIT 10;




DROP view IF EXISTS urban_summary;

CREATE TABLE urban_summary AS
SELECT
    r.date,
    r.time,
    r.ratings,
    r.review_title,
    r.review_comment,
    s.service,
    s.subservice_name,
    s.subservice_charge::numeric,  -- Also cast if needed
    s.city_name,
    s.country_name,
    s.source
FROM uc_reviews r
JOIN services s ON r.review_title ILIKE '%' || s.subservice_name || '%';




SELECT COUNT(*) FROM urban_summary;

SELECT DISTINCT review_title FROM uc_reviews LIMIT 20;
SELECT DISTINCT subservice_name FROM services LIMIT 20;


SELECT r.review_title, s.subservice_name
FROM uc_reviews r
JOIN services s ON s.subservice_name ILIKE '%' || r.review_title || '%'
LIMIT 20;

DROP TABLE IF EXISTS urban_summary;
CREATE TABLE urban_summary AS
SELECT
    r.date,
    r.time,
    r.ratings,
    r.review_title,
    r.review_comment,
    s.service,
    s.subservice_name,
    -- Remove square brackets, ₹ symbol, quotes, then cast to numeric
    TRIM(BOTH ']' FROM TRIM(BOTH '[' FROM REPLACE(REPLACE(s.subservice_charge, '₹', ''), '''', '')))::numeric AS subservice_charge,
    s.city_name,
    s.country_name,
    s.source
FROM uc_reviews r
JOIN services s ON s.subservice_name ILIKE '%' || r.review_title || '%';


SELECT * FROM urban_summary LIMIT 10;

--7. Subservices with Lowest Ratings
SELECT subservice_name, ROUND(AVG(ratings), 2) AS avg_rating, COUNT(*) AS review_count
FROM urban_summary
GROUP BY subservice_name
ORDER BY avg_rating DESC
LIMIT 10;


--3. Most Expensive Subservices (Top by Price)
SELECT subservice_name, MAX(subservice_charge) AS max_price
FROM urban_summary
GROUP BY subservice_name
ORDER BY max_price DESC
LIMIT 10;

--4. City-Wise Average Rating
SELECT city_name, ROUND(AVG(ratings), 2) AS avg_rating, COUNT(*) AS total_reviews
FROM urban_summary
GROUP BY city_name
ORDER BY avg_rating DESC;


-- 5. Service Category Insights
SELECT service, COUNT(*) AS total_reviews, ROUND(AVG(ratings), 2) AS avg_rating
FROM urban_summary
GROUP BY service
ORDER BY total_reviews DESC;

--6. Review Frequency by Hour of the Day
SELECT EXTRACT(HOUR FROM time::TIME) AS review_hour,
       COUNT(*) AS review_count
FROM urban_summary
GROUP BY review_hour
ORDER BY review_hour;


-- 2. Subservices with Most Reviews

SELECT subservice_name, COUNT(*) AS review_count
FROM urban_summary
GROUP BY subservice_name
ORDER BY review_count DESC
LIMIT 10;


-- 2. Subservices with Most Reviews
SELECT DATE_TRUNC('month', date) AS review_month, COUNT(*) AS total_reviews
FROM urban_summary
GROUP BY review_month
ORDER BY review_month;

--1. Monthly Review Trends

SELECT DATE_TRUNC('month', date) AS review_month, COUNT(*) AS total_reviews
FROM urban_summary
GROUP BY review_month
ORDER BY review_month;













