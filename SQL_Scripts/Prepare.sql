USE Retail_Project;
GO

/* =====================================================
   Create Fact_sales table by combining Sales 1997 & 1998
   ===================================================== */

SELECT *
INTO Fact_sales
FROM [Sales 1997]

UNION ALL

SELECT *
FROM [Sales 1998];
GO


/* =========================================
   Add calculated columns (Amount, Profit)
   ========================================= */

ALTER TABLE Fact_sales
ADD 
    Amount DECIMAL(10,2),
    Profit DECIMAL(10,2);
GO


/* =====================================================
   Calculate Amount = quantity * product_retail_price
   Calculate Profit = quantity * (price - cost)
   ===================================================== */

UPDATE S
SET 
    S.Amount = S.quantity * P.product_retail_price,
    S.Profit = S.quantity * (P.product_retail_price - P.product_cost)
FROM Fact_sales S
JOIN Products P 
ON S.product_id = P.product_id;
GO


/* =====================================================
   Add a new Date column in Calendar table
   ===================================================== */

ALTER TABLE Calendar
ADD [Date] DATE;
GO


/* =====================================================
   Create full date using Year, Month, Day columns
   ===================================================== */

UPDATE Calendar
SET [Date] = DATEFROMPARTS([Year], [Month], [Day]);
GO


/* =====================================================
   Make Date column NOT NULL
   ===================================================== */

ALTER TABLE Calendar
ALTER COLUMN [Date] DATE NOT NULL;
GO


/* =====================================================
   Set Date column as Primary Key
   ===================================================== */

ALTER TABLE Calendar 
ADD CONSTRAINT PK_Calendar PRIMARY KEY ([Date]);
GO


/* =====================================================
   Remove old columns (Year, Month, Day)
   because they are now combined in Date
   ===================================================== */

ALTER TABLE Calendar
DROP COLUMN Year, Month, Day;
GO
