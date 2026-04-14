⭐ If you like this project, give it a star!

# 🎯 Hotel Revenue Optimization & Performance Dashboard

## 📌 Project Overview

This project focuses on analyzing hotel booking data to uncover key insights related to revenue, occupancy, cancellations, and customer behavior.

The dashboard is built using **Power BI**, with data processed through **Python** and **PostgreSQL**, following an end-to-end data analytics workflow.

---

## 🚀 Tools & Technologies Used

* 🐍 Python (Pandas) – Data Cleaning
* 🗄 PostgreSQL – Data Storage & SQL Analysis
* 📊 Power BI – Data Visualization & Dashboard
* 📁 CSV Dataset – Hotel Booking Data

---

## 🔄 Project Workflow

1. **Data Collection**

   * Used hotel booking dataset (CSV)

2. **Data Cleaning (Python)**

   * Handled missing values and structured dataset
   * Created new columns (City, Region) for better analysis

```python
import pandas as pd

# Load dataset
df = pd.read_csv("hotel_data.csv")

# Create Region column
df['region'] = df['country'].apply(lambda x: 'Europe' if x in ['PRT','ESP','FRA'] else 'Other')

# Create City column
df['city'] = df['country'].map({
    'PRT': 'Lisbon',
    'GBR': 'London',
    'FRA': 'Paris'
}).fillna('Other')

# Save cleaned data
df.to_csv("hotel_cleaned.csv", index=False)
```

3. **Database (PostgreSQL)**

   * Created database and table
   * Imported cleaned CSV data
   * Built SQL views for optimized analysis

```sql
-- Create Database
CREATE DATABASE hotel_analytics;

-- Create Table
CREATE TABLE bookings (
    hotel TEXT,
    is_canceled INT,
    lead_time INT,
    country TEXT,
    market_segment TEXT,
    adr FLOAT
);

-- Load Data
COPY bookings
FROM 'C:/path/hotel_cleaned.csv'
DELIMITER ','
CSV HEADER;

-- Create View
CREATE VIEW dashboard_data AS
SELECT 
    *,
    CASE 
        WHEN country IN ('PRT','ESP','FRA') THEN 'Europe'
        ELSE 'Other'
    END AS region,
    CASE 
        WHEN country = 'PRT' THEN 'Lisbon'
        WHEN country = 'GBR' THEN 'London'
        WHEN country = 'FRA' THEN 'Paris'
        ELSE 'Other'
    END AS city
FROM bookings;
```

4. **Power BI Dashboard**

   * Developed 4-page interactive dashboard
   * Added KPIs, charts, slicers, and navigation

---

## 📊 Dashboard Pages

### 🏠 1. Home Page

* Navigation-based UI

### 📈 2. Booking & Cancellation Insights

* Platform-wise bookings
* Booking status distribution

### 💰 3. Revenue Analysis

* KPI cards (Revenue, Bookings, Cancellation)
* Scatter and trend analysis

### 📊 4. Executive Overview

* Advanced KPI dashboard (ADR, RevPAR, Occupancy %, Cancellation %)
* Table (performance metrics)
* Pie chart (distribution analysis)
* Combo chart (trend insights)

---

## 📌 Key Metrics (DAX)

* Total Revenue
* Total Bookings
* ADR (Average Daily Rate)
* Occupancy %
* Cancellation %
* RevPAR

---

## 🧠 Key Insights

* Identified ~30–35% revenue contribution from top cities and segments
* Observed ~60–65% occupancy rate and ~25% cancellation trends
* Analyzed booking behavior across market segments and stay types
* Identified high-performing segments driving ~35–40% revenue

---

## 💼 Business Use Case

* Monitor hotel performance
* Optimize pricing strategy
* Reduce cancellations
* Improve revenue planning

---

## 🔗 Author

**Dipendra Pardhi**

