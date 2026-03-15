# 📊 Retail Sales & Customer Analytics (SQL & Power BI)

## 📌 Project Overview

This project analyzes retail sales data from **1997–1998** using **SQL Server (T-SQL)** and **Power BI** to uncover key business insights related to revenue growth, customer behavior, and product performance.

The project demonstrates the full **data analytics workflow**, including data preparation, transformation, analytical querying, and building an interactive Business Intelligence dashboard to support data-driven decision making.

---

# 📂 Dataset Structure

The dataset used in this project consists of multiple tables representing different aspects of the retail business, including customers, products, sales transactions, and returns.

| Table Name     | Description                                                                                                                  |
| -------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| **Calendar**   | A date dimension table used for time-based analysis such as year, quarter, and month trends.                                 |
| **Customers**  | Contains customer demographic information including occupation, income level, and attributes used for customer segmentation. |
| **Products**   | Product catalog including product categories, subcategories, and pricing details.                                            |
| **Region**     | Geographic dimension used to analyze sales performance across different regions.                                             |
| **Returns**    | Records of returned products used to calculate return rates and analyze product quality.                                     |
| **Sales_1997** | Transactional sales data for the year **1997** used for sales performance analysis.                                          |
| **Sales_1998** | Transactional sales data for the year **1998** used for year-over-year comparison and growth analysis.                       |
| **Stores**     | Store information including store identifiers, store locations, and regional assignments.                                    |

These tables were integrated and transformed using **SQL Server (T-SQL)** to create a structured dataset for analytical reporting in Power BI.

---

# ❓ Business Questions

This analysis aims to answer several key business questions:

* How did revenue change between **1997 and 1998**?
* Which **customer segments** generate the highest revenue?
* Which **products have the highest return rates**?
* Which **regions and stores perform best**?
* What factors contribute most to **profitability**?

---

# 🚀 Key Analytical Insights

### 📈 Revenue Growth

Revenue increased by **112.18% year-over-year**, growing from **$0.57M to $1.20M**, indicating strong business growth.

### 💰 Profitability

The business maintained an average **59% profit margin**, demonstrating efficient cost management and pricing strategy.

### 👥 Customer Segments

Customers in the **"Professional"** and **"Skilled Manual"** occupations with annual incomes between **$30K–$50K** were identified as the primary revenue drivers.

### 📦 Product Quality

Products with **return rates above 2.5%** were identified, highlighting potential opportunities for **quality control and packaging improvements**.

---

# 🛠️ Technical Stack

### Data Processing

* SQL Server (T-SQL)
* Data Cleaning and Transformation
* Analytical SQL Queries
* SQL Views for Reporting

### Data Visualization

* Power BI
* Interactive Dashboard Design
* KPI Development
* Data Storytelling

---

# ⚙️ Data Workflow

The project follows a structured data analytics pipeline from raw data preparation to business intelligence visualization.

**1️⃣ Raw Data Sources**
Retail data was initially stored in multiple Excel tables including sales transactions, customer information, products, returns, and store data.

**2️⃣ Data Preparation (SQL Server)**
The raw tables were imported into SQL Server where the following steps were performed:

* Data cleaning and handling missing values
* Combining transactional tables
* Creating calculated fields such as **Amount** and **Profit**
* Standardizing column formats for analysis

**3️⃣ Data Modeling**

A relational data model was created connecting:

* Sales tables
* Customers
* Products
* Stores
* Calendar

This structure enabled efficient analytical queries.

**4️⃣ Analytical SQL Queries**

SQL queries and views were developed to calculate key metrics such as:

* Total Revenue
* Total Profit
* Return Rate
* Customer Segment Performance
* Year-over-Year Growth

**5️⃣ Power BI Data Model**

The SQL views were connected directly to Power BI to create a semantic data model for reporting.

**6️⃣ Dashboard Development**

An interactive Power BI dashboard was created to visualize business performance using:

* KPI cards
* Sales trend charts
* Geographic sales heat maps
* Customer demographic analysis
* Product return analysis

---
---

# 🗂️ Data Model

This project follows a **Star Schema data model**, commonly used in data warehousing and business intelligence systems.

The schema consists of **Fact Tables** that store transactional data and **Dimension Tables** that provide descriptive attributes used for analysis.

---

## ⭐ Fact Tables

### **Fact_sales**

The main transactional table that records every sales operation.

| Column | Description |
|------|-------------|
| transaction_date | Date when the sale occurred |
| stock_date | Date when the product was stocked |
| product_id | Reference to the product sold |
| customer_id | Reference to the customer |
| store_id | Reference to the store |
| quantity | Number of units sold |

---

### **Returns**

Stores data about returned products.

| Column | Description |
|------|-------------|
| return_date | Date when the product was returned |
| product_id | Returned product |
| store_id | Store where the return occurred |
| quantity | Number of returned units |

---

## 📊 Dimension Tables

### **Customers**

Contains customer demographic information used for segmentation analysis.

Key attributes include:

- customer_id (Primary Key)
- customer_acct_num
- first_name
- last_name
- birthdate
- marital_status
- yearly_income
- gender
- education
- occupation
- homeowner
- member_card

---

### **Products**

Stores information about the products sold.

Key attributes include:

- product_id (Primary Key)
- product_brand
- product_name
- product_sku
- product_retail_price
- product_cost
- product_weight
- recyclable
- low_fat

---

### **Stores**

Contains information about retail stores.

Key attributes include:

- store_id (Primary Key)
- region_id
- store_type
- store_name
- store_city
- store_state
- store_country
- first_opened_date
- last_remodel_date
- total_sqft

---

### **Region**

Defines geographical sales regions.

| Column | Description |
|------|-------------|
| region_id | Primary key for region |
| sales_district | Sales district |
| sales_region | Sales region |

---

### **Calendar**

Date dimension table used for time-based analysis.

| Column | Description |
|------|-------------|
| Date | Primary key representing calendar date |

---

## 🔗 Relationships

The schema follows **one-to-many relationships** between dimension tables and fact tables.

| Dimension Table | Fact Table | Join Key |
|----------------|------------|---------|
| Customers | Fact_sales | customer_id |
| Products | Fact_sales | product_id |
| Products | Returns | product_id |
| Stores | Fact_sales | store_id |
| Stores | Returns | store_id |
| Region | Stores | region_id |
| Calendar | Fact_sales | Date → transaction_date |
| Calendar | Returns | Date → return_date |

---

## 🧠 Schema Notes

- The model primarily follows a **Star Schema design**.
- A small **Snowflake structure** exists where the **Region** table connects to **Stores**.
- This structure allows flexible analysis across:

  - Customer demographics  
  - Product performance  
  - Regional sales  
  - Time-based trends  
  - Product return rates  

This schema supports efficient analytical queries used in the **Power BI dashboard**.
# 📊 Dashboard Features

The Power BI dashboard includes:

* Revenue & Profit KPIs
* Sales Trend Analysis
* Customer Demographic Insights
* Product Return Rate Analysis
* Regional Sales Performance
* Interactive Filters (Region, Product, Store)

---

# 📸 Dashboard Preview

|    **Dashboard Overview**    | **Customer Demographic & Behavioral Analysis** |  **Key Analytical Insights** |
| :--------------------------: | :--------------------------------------------: | :--------------------------: |
| ![Page 1](picture/pic_1.png) |          ![Page 2](picture/pic_2.png)          | ![Page 3](picture/pic_3.png) |

---

# 💡 Skills Demonstrated

* SQL Data Cleaning & Transformation
* Data Modeling
* Business KPI Development
* Power BI Dashboard Development
* Customer Segmentation Analysis
* Data Visualization & Storytelling

---

# 📬 Contact

**Developed by Gergess Magdy**

If you have any questions about the SQL queries, data model, or dashboard design, feel free to reach out.

🔗 LinkedIn
https://www.linkedin.com/in/gergess-magdy-b93790311
