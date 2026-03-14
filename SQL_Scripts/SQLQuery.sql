USE Retail_Project;
GO

/* =====================================================
   Question 1:
   Total revenue and profit for 1997 vs 1998
   ===================================================== */

CREATE VIEW vw_YearlyRevenueProfit AS
SELECT 
    YEAR(s.transaction_date) AS [Year],
    ROUND(SUM(s.Amount),2) AS Total_Revenue,
    ROUND(SUM(s.Profit),2) AS Total_Profit
FROM Fact_sales s
GROUP BY YEAR(s.transaction_date);
GO

/* View yearly revenue & profit */
SELECT * FROM vw_YearlyRevenueProfit;
GO


/* =====================================================
   Annual Revenue Growth Rate
   ===================================================== */

CREATE OR ALTER VIEW vw_AnnualRevenueGrowth AS
SELECT Revenue_Growth_Rate
FROM (
    SELECT 
        [Year],
        ((Total_Revenue - LAG(Total_Revenue) OVER (ORDER BY [Year]))
        / NULLIF(LAG(Total_Revenue) OVER (ORDER BY [Year]),0)) 
         AS Revenue_Growth_Rate
    FROM vw_YearlyRevenueProfit
) AS T
WHERE [Year] = 1998;
GO


/* =====================================================
   Question 2:
   Monthly revenue trends
   ===================================================== */

CREATE VIEW vw_MonthlyRevenue AS
SELECT
    FORMAT(transaction_date,'yyyy-MM') AS YearMonth,
    ROUND(SUM(Amount),2) AS Monthly_Revenue
FROM Fact_sales
GROUP BY FORMAT(transaction_date,'yyyy-MM');
GO

/* View monthly revenue */
SELECT * 
FROM vw_MonthlyRevenue
ORDER BY YearMonth;
GO


/* Top seasonal revenue months */

SELECT TOP 5
    YearMonth,
    Monthly_Revenue
FROM vw_MonthlyRevenue
ORDER BY Monthly_Revenue DESC;
GO


/* =====================================================
   Question 3:
   Top 10 products by profit
   ===================================================== */

CREATE VIEW vw_TopProductsProfit AS
SELECT TOP 10
    p.product_name AS Product_Name,
    ROUND(SUM(s.Profit),2) AS Products_Profit
FROM Fact_sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY Products_Profit DESC;
GO


/* =====================================================
   Top 10 brands by quantity sold
   ===================================================== */

CREATE VIEW vw_TopBrandsSold AS
SELECT TOP 10
    p.product_brand AS Brand_Name,
    SUM(s.quantity) AS Total_Quantity_Sold
FROM Fact_sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY p.product_brand
ORDER BY Total_Quantity_Sold DESC;
GO


/* =====================================================
   Question 4:
   Products with highest return rate
   ===================================================== */

CREATE OR ALTER VIEW vw_ProductReturnRate AS

WITH SalesAgg AS (
    SELECT product_id, SUM(quantity) AS Total_Sold
    FROM Fact_sales
    GROUP BY product_id
),
ReturnsAgg AS (
    SELECT product_id, SUM(quantity) AS Total_Returned
    FROM [Returns]
    GROUP BY product_id
)

SELECT TOP 10
    p.product_name,
    sa.Total_Sold,
    ra.Total_Returned,
    CAST(ra.Total_Returned AS FLOAT) / NULLIF(sa.Total_Sold,0) AS Return_Rate_Percentage
FROM Products p
LEFT JOIN SalesAgg sa ON p.product_id = sa.product_id
LEFT JOIN ReturnsAgg ra ON p.product_id = ra.product_id
ORDER BY Return_Rate_Percentage DESC;
GO


/* =====================================================
   Stores with highest return rate
   ===================================================== */

CREATE OR ALTER VIEW vw_StoreReturnRate AS

WITH SalesAgg AS (
    SELECT store_id, SUM(quantity) AS Total_Sold
    FROM Fact_sales
    GROUP BY store_id
),
ReturnsAgg AS (
    SELECT store_id, SUM(quantity) AS Return_Quantity
    FROM [Returns]
    GROUP BY store_id
)

SELECT TOP 10
    st.store_state AS store_state,
    sa.Total_Sold,
    ra.Return_Quantity,
    CAST(ra.Return_Quantity AS FLOAT) / NULLIF(sa.Total_Sold,0) AS Return_Rate_Percentage
FROM Stores st
LEFT JOIN SalesAgg sa ON st.store_id = sa.store_id
LEFT JOIN ReturnsAgg ra ON st.store_id = ra.store_id
ORDER BY Return_Rate_Percentage DESC;
GO


/* =====================================================
   Question 5:
   Sales by customer segments
   ===================================================== */

CREATE VIEW vw_CustomerSegmentsSales AS

SELECT 
    'Education' AS Segment,
    c.education AS Value,
    ROUND(SUM(s.Amount),2) AS Total_Sales
FROM Fact_sales s
JOIN Customers c ON s.customer_id = c.customer_id
GROUP BY c.education

UNION ALL

SELECT 
    'Yearly Income',
    CAST(c.yearly_income AS VARCHAR(50)),
    ROUND(SUM(s.Amount),2)
FROM Fact_sales s
JOIN Customers c ON s.customer_id = c.customer_id
GROUP BY c.yearly_income

UNION ALL

SELECT 
    'Member Card',
    ISNULL(c.member_card,'None'),
    ROUND(SUM(s.Amount),2)
FROM Fact_sales s
JOIN Customers c ON s.customer_id = c.customer_id
GROUP BY c.member_card;
GO


/* =====================================================
   Question 6:
   Store size vs revenue efficiency
   ===================================================== */

CREATE VIEW vw_StoreRevenueEfficiency AS
SELECT 
    st.store_id,
    st.store_city,
    st.total_sqft AS Store_Size,
    ROUND(SUM(s.Amount),2) AS Total_Revenue,
    ROUND(SUM(s.Amount) / NULLIF(st.total_sqft,0),2) AS Revenue_Per_Sqft
FROM Stores st
JOIN Fact_sales s ON st.store_id = s.store_id
GROUP BY st.store_id, st.store_city, st.total_sqft;
GO


/* =====================================================
   Question 7:
   Top 10 customers by total spend
   ===================================================== */

CREATE VIEW vw_TopCustomersSpend AS
SELECT TOP 10
    c.customer_id,
    CONCAT(c.first_name,' ',c.last_name) AS Customer_Name,
    c.education,
    c.yearly_income,
    c.occupation,
    c.member_card,
    ROUND(SUM(s.Amount),2) AS Total_Spend
FROM Fact_sales s
JOIN Customers c ON s.customer_id = c.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.education,
    c.yearly_income,
    c.occupation,
    c.member_card
ORDER BY Total_Spend DESC;
GO