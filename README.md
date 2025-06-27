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
  *Database Creation: The project starts by creating a database named airbnb
  *Table Creation: A table named airbnb_listings is created to store the data. The table structure includes columns for id, name, host_id, host_name, neighbourhood, latitude, longitude, room_type, price, number_of_reviews, calculated_host_listings_count, availability_365.

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
