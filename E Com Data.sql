------==========================================================================================
----- Step 1: Text Standardisation
------=========================================================================================
SELECT 
  INITCAP(` Product`),
  INITCAP(LOWER(Category))
FROM `project-bb3551be-8ada-46bf-bfa.commercedata.E commerce Data`

------=========================================================================================
------ Step 2: Handling null values in catergory
------=========================================================================================


SELECT
  Category,
  ` Product`,
  CASE ` Product`
    WHEN 'Headphones' THEN 'Electronics'
    WHEN 'Shoes' THEN 'Clothing'
    WHEN 'Vacuum' THEN 'Home'
    WHEN 'Jeans' THEN 'Clothing'
    WHEN 'Basketball' THEN 'Sports'
    WHEN 'Yoga Mat' THEN 'Sports'
    WHEN 'T-Shirt' THEN 'Clothing'
    WHEN 'Blender' THEN 'Home'
    WHEN 'Biography' THEN 'Books'
    WHEN 'Smartphone' THEN 'Electronics'
    WHEN 'Laptop' THEN 'Electronics'
    ELSE Category
    END
    AS Category_cleaned
FROM `project-bb3551be-8ada-46bf-bfa.commercedata.E commerce Data`


------=========================================================================================
------ Step 3: Handling negative quantity values
------=========================================================================================


SELECT 
    -- 1. Quantity Cleaning (Simplified back to standard logic)
    Quantity,
    IFNULL(ABS(SAFE_CAST(Quantity AS INT64)), 0) AS Quantity_cleaned,

    -- 2. Price Cleaning (handling string words)
    Price, 
    CASE 
      WHEN LOWER(TRIM(Price)) = 'four hundred' THEN 400.0
      ELSE IFNULL(ABS(SAFE_CAST(Price AS FLOAT64)), 0)
    END AS Price_cleaned

FROM `project-bb3551be-8ada-46bf-bfa.commercedata.E commerce Data`

------=========================================================================================
------ Step 5: Fixing date logic
------=========================================================================================
SELECT
  Order_Date,
  COALESCE(
    SAFE.PARSE_DATE('%Y-%m-%d', Order_Date),
    SAFE.PARSE_DATE('%d/%m/%Y', Order_Date),
    SAFE.PARSE_DATE('%m/%d/%Y', Order_Date), -- Handles US format
    SAFE.PARSE_DATE('%b %e %Y', Order_Date)  -- Handles 'Jan 5 2023'
  ) AS date_cleaned
FROM `project-bb3551be-8ada-46bf-bfa.commercedata.E commerce Data` 
ORDER BY date_cleaned DESC

------=========================================================================================
------ Step 6: Full Query 
------=========================================================================================
------==========================================================================================
----- Final Cleaned View: Selected Columns Only
------=========================================================================================
SELECT
  -- Original IDs and Metadata
  ID,
  'Customer_Name',
  Order_ID,
  Total,
  Status,
  Payment_Method,

  -- Cleaned Attributes
  INITCAP(` Product`) AS Product_cleaned,
  CASE ` Product`
    WHEN 'Headphones' THEN 'Electronics'
    WHEN 'Shoes' THEN 'Clothing'
    WHEN 'Vacuum' THEN 'Home'
    WHEN 'Jeans' THEN 'Clothing'
    WHEN 'Basketball' THEN 'Sports'
    WHEN 'Yoga Mat' THEN 'Sports'
    WHEN 'T-Shirt' THEN 'Clothing'
    WHEN 'Blender' THEN 'Home'
    WHEN 'Biography' THEN 'Books'
    WHEN 'Smartphone' THEN 'Electronics'
    WHEN 'Laptop' THEN 'Electronics'
    ELSE Category
    END
    AS Category_cleaned,
  IFNULL(ABS(SAFE_CAST(Quantity AS INT64)), 0) AS Quantity_cleaned,
  CASE
    WHEN LOWER(TRIM(Price)) = 'four hundred' THEN 400.0
    ELSE IFNULL(ABS(SAFE_CAST(REPLACE(Price, '$', '') AS FLOAT64)), 0)
    END
    AS Price_cleaned,
  COALESCE(
    SAFE.PARSE_DATE('%Y-%m-%d', Order_Date),
    SAFE.PARSE_DATE('%d/%m/%Y', Order_Date),
    SAFE.PARSE_DATE('%m/%d/%Y', Order_Date),
    SAFE.PARSE_DATE('%b %e %Y', Order_Date))
    AS date_cleaned
FROM `project-bb3551be-8ada-46bf-bfa.commercedata.E commerce Data`
ORDER BY date_cleaned DESC




