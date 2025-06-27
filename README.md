# Airbnb Price Listing with SQL

## Introduction
This project explores a dataset of Airbnb listings to derive meaningful insights about pricing, availability, customer behavior, and host activities using SQL. The goal is to identify listing patterns, evaluate market segments (e.g., by price or availability), and extract actionable insights for business decision-making or traveler preferences. This project demonstrates the practical use of SQL for data analysis, involving aggregation, filtering, subqueries, and window functions.

## Data Description
The dataset analyzed consists of cleaned Airbnb listing data with the following key fields:
id: Unique identifier for each listing
name: Title of the listing
host_id, host_name: Host identity and name
neighbourhood: Geographic location
latitude, longitude: Coordinates of the property
room_type: Type of room (e.g., Entire home, Private room)
price: Listing price in USD
number_of_reviews: Count of total reviews received
calculated_host_listings_count: Number of listings per host
availability_365: Number of days the listing is available in a year

## Methodology
The analysis was carried out SQL and Excel covering the following:
Data cleaning using excel
Data categorization using CASE statements (e.g., price bands, availability)
Grouping and aggregation to count listings, compute averages
Subqueries for contextual comparisons (e.g., above-average price)
Window functions (RANK(), SUM() OVER) for intra-group ranking and cumulative analysis
CTEs to improve readability and performance

Each query was structured to answer a specific business or analytical question.

## Technologies Used
MySql, Excel

## Result
📌 1. Price Categories
Listings were grouped into Budget, Mid-range, Premium, and Luxury. The Mid-range ($100-$200) category had the most listings, indicating that most hosts target average-budget travelers.

📌 2. Top-Rated Listings
By ranking listings by review count per neighborhood, we identified the most-reviewed (likely most popular) properties, offering insights into customer trust and booking trends.

📌 3. Availability Performance
Listings were labeled as “High” or “Low” availability based on the neighborhood average. This can help identify hosts who may be under-utilizing their property.

📌 4. Cumulative Pricing
The cumulative price trends showed how price accumulates across listings within a neighborhood, useful for competitive pricing analysis.

📌 5. Top Listings in Cambridge
We identified the top 5 most expensive listings in Cambridge, valuable for luxury travelers or market targeting.

📌 6. Listings & Price by Neighborhood
Popular neighborhoods were ranked by listing count and average price, helping determine demand hotspots.

📌 7. Host Activity
Hosts with more than 10 listings were analyzed. Some had hundreds of reviews, indicating large-scale hosting businesses.

📌 8. Room Type Distribution
Entire homes and apartments dominated the dataset, followed by private rooms. Shared rooms had the lowest share.

📌 9. Perfect Availability
Some listings were available all 365 days at prices under $100 — ideal options for long-term or budget travelers.

📌 10. Most Reviewed Neighborhoods
Neighborhoods with the highest average reviews per listing were highlighted, indicating vibrant booking activity.

📌 11. Overpriced & Unreviewed
Some listings with no reviews were priced higher than the average in their area — possibly signaling overpricing or lack of traction.

📌 12. Proximity to Harvard Square
Properties within 0.5 degrees of Harvard Square were extracted — helpful for academic visitors or location-based targeting.

## Conclusion
This project successfully demonstrated how SQL can uncover actionable insights from Airbnb data. Key findings included the distribution of price categories, identification of high-performing hosts, and availability trends. Such insights could be valuable to both Airbnb and hosts for pricing strategies, customer engagement, and market segmentation.
