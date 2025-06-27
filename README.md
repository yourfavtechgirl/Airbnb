# Airbnb Price Listing with SQL

## Introduction
This project explores a dataset of Airbnb listings to derive meaningful insights about pricing, availability, customer behavior, and host activities using SQL. The goal is to identify listing patterns, evaluate market segments (e.g., by price or availability), and extract actionable insights for business decision-making or traveler preferences. 

## Objectives
1. Set up a database: Create and populate a database with the provided data.
2. Data Cleaning: Identify and remove any records with missing or null values.
3. Exploratory Data Analysis (EDA): Perform basic exploratory data analysis to understand the dataset.
4. Business Analysis: Use SQL to answer specific business questions and derive insights from the data.

## Project Structure
  ### 1. Database Setup
  * Database Creation: The project starts by creating a database named airbnb
  * Table Creation: A table named airbnb_listings is created to store the data. The table structure includes columns for id, name, host_id, host_name, neighbourhood, latitude, longitude, room_type, price, number_of_reviews, calculated_host_listings_count, availability_365.

```sql
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
```
### 2. Data Exploration and Cleaning
   * Record Count: Determine the total number of records in the dataset.
   * Customer Count: Find out how many unique customers are in the dataset.
   *  Validate Latitude and Longitude Ranges
   * Check for Listings with Invalid Availability (more than 365 days)

 ```sql
         SELECT COUNT(*) FROM airbnb_listings;
```
```sql
    SELECT COUNT(DISTINCT id) FROM airbnb_listings;
```
```sql
    SELECT * FROM airbnb_listings
    WHERE latitude NOT BETWEEN -90 AND 90
     OR longitude NOT BETWEEN -180 AND 180;
```
```sql
     SELECT * FROM airbnb_listings
    WHERE availability_365 > 365 OR availability_365 < 0;
```

### Data Analysis and Findings
1. Categorize listings by price range 
```sql
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
```
2. Rank listings by reviews within each neighborhood
```sql
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
```
 3. What are the top 5 most expensive listings in Cambridge, and what are their details?
```sql
SELECT name, neighbourhood, room_type, price, host_name
FROM airbnb_listings
ORDER BY price DESC
LIMIT 5;
```
4. How many listings are available in each neighborhood, and what is the average price per neighborhood?
```sql
SELECT neighbourhood, 
       COUNT(*) AS listing_count, 
       ROUND(AVG(price), 2) AS avg_price
FROM airbnb_listings
GROUP BY neighbourhood
ORDER BY listing_count DESC;
```
 5. Label listings by availability compared to neighborhood average
```sql
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
```
6. Cumulative sum of prices within each neighborhood 
```sql
SELECT 
    name, 
    neighbourhood, 
    price,
    SUM(price) OVER (PARTITION BY neighbourhood ORDER BY price) AS cumulative_price
FROM airbnb_listings
ORDER BY neighbourhood, price
LIMIT 5;
```
7. Which hosts have the most listings, and how many reviews do their listings have in total?
```sql
SELECT host_name, 
       calculated_host_listings_count, 
       SUM(number_of_reviews) AS total_reviews
FROM airbnb_listings
GROUP BY host_id, host_name, calculated_host_listings_count
HAVING calculated_host_listings_count > 10
ORDER BY calculated_host_listings_count DESC
LIMIT 5;
```
8. What is the distribution of room types across all listings?
```sql
SELECT room_type, 
       COUNT(*) AS count, 
       ROUND((COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()), 2) AS percentage
FROM airbnb_listings
GROUP BY room_type
ORDER BY count DESC;
```
9. Which listings have perfect availability (365 days) and a price under $100?
```sql
SELECT name, neighbourhood, room_type, price
FROM airbnb_listings
WHERE availability_365 = 365 AND price < 100
ORDER BY price ASC;
```
10. What are the top 5 neighborhoods with the highest average number of reviews per listing?
```sql
SELECT neighbourhood, 
       ROUND(AVG(number_of_reviews), 2) AS avg_reviews
FROM airbnb_listings
GROUP BY neighbourhood
HAVING COUNT(*) > 5
ORDER BY avg_reviews DESC
LIMIT 5;
```
11. How many listings are within 0.5 degrees of latitude and longitude from Harvard Square (42.3736, -71.1189)?
```sql
SELECT name, neighbourhood, room_type, price
FROM airbnb_listings
WHERE latitude BETWEEN 42.3736 - 0.5 AND 42.3736 + 0.5
  AND longitude BETWEEN -71.1189 - 0.5 AND -71.1189 + 0.5
ORDER BY price ASC;
```
## 📊 Key Findings
1. Price Categorization

* Most listings fall into the budget and mid-range categories (below $200).

* Only a small portion of listings are classified as luxury (>$500).

2. Top Reviewed Listings by Neighborhood

* The highest-reviewed listings in each neighborhood were identified.

* These listings can serve as benchmarks for popularity and guest satisfaction.

3. Most Expensive Listings

* The top 5 listings by price were extracted.

* These listings are mostly concentrated in premium neighborhoods and offer unique room types.

4. Neighborhood Insights

* Neighborhoods with the highest listing counts include areas with central access or tourist appeal.

* Average prices vary significantly by neighborhood, indicating location-based pricing trends.

5. Availability Analysis

* Listings were labeled as having high or low availability based on their neighborhood average.

* This reveals which listings are over- or under-utilized within their local market.

6. Cumulative Pricing

* Cumulative sum of prices within each neighborhood helps track overall market size and pricing tiers.

7. Top Hosts

* Hosts with more than 10 listings were identified.

* The total number of reviews per host gives an idea of their engagement and popularity.


8. Room Type Distribution

* Entire homes/apartments dominate the market.

 
* Private rooms are the next most common, with shared rooms making up a small fraction



9. Value Listings

* Identified listings with full-year availability and prices under $100 — ideal for budget-conscious long-term guests.
  
  
10. Most Engaged Neighborhoods

* Top neighborhoods by average number of reviews per listing suggest higher guest traffic and engagement.

11. Proximity to Harvard Square

* 0.5° radius query revealed listings near Harvard Square, helping in location-based accommodation targeting.



## Conclusion
This project successfully demonstrated how SQL can uncover actionable insights from Airbnb data. Key findings included the distribution of price categories, identification of high-performing hosts, and availability trends. Such insights could be valuable to both Airbnb and hosts for pricing strategies, customer engagement, and market segmentation.


