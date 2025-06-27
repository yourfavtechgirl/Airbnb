CREATE DATABASE airbnb;


CREATE TABLE airbnb_listings (
    id BIGINT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    host_id BIGINT NOT NULL,
    host_name VARCHAR(100),
    neighbourhood VARCHAR(100),
    latitude DECIMAL(10, 6),
    longitude DECIMAL(10, 6),
    room_type VARCHAR(50),
    price DECIMAL(10, 2),
    number_of_reviews INT DEFAULT 0,
    calculated_host_listings_count INT DEFAULT 1,
    availability_365 INT DEFAULT 0
);

SELECT COUNT(*) FROM airbnb_listings;

SELECT COUNT(DISTINCT id) FROM airbnb_listings;

SELECT * FROM airbnb_listings
WHERE latitude NOT BETWEEN -90 AND 90
   OR longitude NOT BETWEEN -180 AND 180;
   
   SELECT * FROM airbnb_listings
WHERE availability_365 > 365 OR availability_365 < 0;





select * from airbnb_listings;

-- 1. Categorize listings by price range 
SELECT 
    CASE 
        WHEN price < 100 THEN 'Budget (<$100)'
        WHEN price BETWEEN 100 AND 200 THEN 'Mid-range ($100-$200)'
        WHEN price BETWEEN 201 AND 500 THEN 'Premium ($201-$500)'
        ELSE 'Luxury (>$500)'
    END AS price_category,
    COUNT(*) AS listing_count
FROM airbnb_listings
GROUP BY price_category
ORDER BY listing_count DESC;

-- 2. Rank listings by reviews within each neighborhood
WITH RankedListings AS (
    SELECT 
        name, 
        neighbourhood, 
        number_of_reviews,
        RANK() OVER (PARTITION BY neighbourhood ORDER BY number_of_reviews DESC) AS review_rank
    FROM airbnb_listings
)
SELECT name, neighbourhood, number_of_reviews
FROM RankedListings
WHERE review_rank = 1
ORDER BY number_of_reviews DESC
LIMIT 5;

-- 	3. What are the top 5 most expensive listings in Cambridge, and what are their details?
SELECT name, neighbourhood, room_type, price, host_name
FROM airbnb_listings
ORDER BY price DESC
LIMIT 5;

-- 4. How many listings are available in each neighborhood, and what is the average price per neighborhood?
SELECT neighbourhood, 
       COUNT(*) AS listing_count, 
       ROUND(AVG(price), 2) AS avg_price
FROM airbnb_listings
GROUP BY neighbourhood
ORDER BY listing_count DESC;

-- 5. Label listings by availability compared to neighborhood average
SELECT 
    name, 
    neighbourhood, 
    availability_365,
    CASE 
        WHEN availability_365 > (
            SELECT AVG(availability_365) 
            FROM airbnb_listings sub 
            WHERE sub.neighbourhood = main.neighbourhood
        ) THEN 'High Availability'
        ELSE 'Low Availability'
    END AS availability_status
FROM airbnb_listings main
WHERE availability_365 IS NOT NULL
ORDER BY availability_365 DESC
LIMIT 5;

-- 6. Cumulative sum of prices within each neighborhood 
SELECT 
    name, 
    neighbourhood, 
    price,
    SUM(price) OVER (PARTITION BY neighbourhood ORDER BY price) AS cumulative_price
FROM airbnb_listings
ORDER BY neighbourhood, price
LIMIT 5;


-- 7. Which hosts have the most listings, and how many reviews do their listings have in total?
SELECT host_name, 
       calculated_host_listings_count, 
       SUM(number_of_reviews) AS total_reviews
FROM airbnb_listings
GROUP BY host_id, host_name, calculated_host_listings_count
HAVING calculated_host_listings_count > 10
ORDER BY calculated_host_listings_count DESC
LIMIT 5;

-- 8. What is the distribution of room types across all listings?
SELECT room_type, 
       COUNT(*) AS count, 
       ROUND((COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()), 2) AS percentage
FROM airbnb_listings
GROUP BY room_type
ORDER BY count DESC;

-- 9. Which listings have perfect availability (365 days) and a price under $100?
SELECT name, neighbourhood, room_type, price
FROM airbnb_listings
WHERE availability_365 = 365 AND price < 100
ORDER BY price ASC;


-- 10. What are the top 5 neighborhoods with the highest average number of reviews per listing?
SELECT neighbourhood, 
       ROUND(AVG(number_of_reviews), 2) AS avg_reviews
FROM airbnb_listings
GROUP BY neighbourhood
HAVING COUNT(*) > 5
ORDER BY avg_reviews DESC
LIMIT 5;

-- 11. How many listings are within 0.5 degrees of latitude and longitude from Harvard Square (42.3736, -71.1189)?
SELECT name, neighbourhood, room_type, price
FROM airbnb_listings
WHERE latitude BETWEEN 42.3736 - 0.5 AND 42.3736 + 0.5
  AND longitude BETWEEN -71.1189 - 0.5 AND -71.1189 + 0.5
ORDER BY price ASC;










