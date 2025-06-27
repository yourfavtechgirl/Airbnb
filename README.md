# Airbnb
Airbnb price listing with SQL
🔹 1. Introduction
This project explores a dataset of Airbnb listings to derive meaningful insights about pricing, availability, customer behavior, and host activities using SQL. The goal is to identify listing patterns, evaluate market segments (e.g., by price or availability), and extract actionable insights for business decision-making or traveler preferences. This project demonstrates the practical use of SQL for data analysis, involving aggregation, filtering, subqueries, and window functions.

🔹 2. Data Description
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

The data was imported into a MySQL database with proper data types and constraints for robust querying.
