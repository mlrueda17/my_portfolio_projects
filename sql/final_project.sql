-- 1. Highest Sales Product Category in 2023
WITH ProductSales AS (
    SELECT 
        p.PRODUCT_NAME,
        SUM(s.UNITS_SOLD * s.PRICE_PER_UNIT) AS TOTAL_SALES
    FROM RUSH_SALES.PUBLIC.SALES s
    JOIN RUSH_SALES.PUBLIC.PRODUCT p 
        ON s.PRODUCT_ID = p.PRODUCT_ID
    WHERE YEAR(s.INVOICE_DATE) = 2023
    GROUP BY p.PRODUCT_NAME
)
SELECT PRODUCT_NAME, TOTAL_SALES
FROM ProductSales
ORDER BY TOTAL_SALES DESC
LIMIT 1;

-- 2. Top State Sales (Men's & Women's) in 2023
WITH StateSales AS (
    SELECT 
        r.STATE,
        p.PRODUCT_NAME,
        SUM(s.UNITS_SOLD * s.PRICE_PER_UNIT) AS TOTAL_SALES
    FROM RUSH_SALES.PUBLIC.SALES s
    JOIN RUSH_SALES.PUBLIC.RETAILER r 
        ON s.RETAIL_LOCATION_ID = r.RETAIL_LOCATION_ID
    JOIN RUSH_SALES.PUBLIC.PRODUCT p 
        ON s.PRODUCT_ID = p.PRODUCT_ID
    WHERE YEAR(s.INVOICE_DATE) = 2023
        AND (p.PRODUCT_NAME LIKE '%Men%' OR p.PRODUCT_NAME LIKE '%Women%')
    GROUP BY r.STATE, p.PRODUCT_NAME
)
SELECT 
    PRODUCT_NAME,
    STATE,
    TOTAL_SALES
FROM (
    SELECT 
        PRODUCT_NAME,
        STATE,
        TOTAL_SALES,
        RANK() OVER (PARTITION BY PRODUCT_NAME ORDER BY TOTAL_SALES DESC) AS rnk
    FROM StateSales
) ranked
WHERE rnk = 1;
-- 3. Average Units Sold Per Order (2023 & 2022)
SELECT 
    YEAR(INVOICE_DATE) AS YEAR,
    AVG(UNITS_SOLD) AS AVG_UNITS_SOLD
FROM RUSH_SALES.PUBLIC.SALES
WHERE YEAR(INVOICE_DATE) IN (2022, 2023)
GROUP BY YEAR(INVOICE_DATE)
ORDER BY YEAR(INVOICE_DATE);

-- 4. Top Retailer per Product Category
WITH RetailerSales AS (
    SELECT 
        r.RETAILER,
        p.PRODUCT_NAME,
        SUM(s.UNITS_SOLD * s.PRICE_PER_UNIT) AS TOTAL_SALES
    FROM RUSH_SALES.PUBLIC.SALES s
    JOIN RUSH_SALES.PUBLIC.RETAILER r 
        ON s.RETAIL_LOCATION_ID = r.RETAIL_LOCATION_ID
    JOIN RUSH_SALES.PUBLIC.PRODUCT p 
        ON s.PRODUCT_ID = p.PRODUCT_ID
    GROUP BY r.RETAILER, p.PRODUCT_NAME
)
SELECT 
    PRODUCT_NAME,
    RETAILER,
    TOTAL_SALES
FROM (
    SELECT 
        PRODUCT_NAME,
        RETAILER,
        TOTAL_SALES,
        RANK() OVER (PARTITION BY PRODUCT_NAME ORDER BY TOTAL_SALES DESC) AS rnk
    FROM RetailerSales
) ranked
WHERE rnk = 1;

-- 5. Data for Tableau Analysis
SELECT 
    s.INVOICE_DATE,
    r.RETAILER,
    r.STATE,
    r.REGION,
    p.PRODUCT_NAME,
    s.SALES_METHOD,
    SUM(s.UNITS_SOLD) AS TOTAL_UNITS,
    SUM(s.UNITS_SOLD * s.PRICE_PER_UNIT) AS TOTAL_SALES
FROM RUSH_SALES.PUBLIC.SALES s
JOIN RUSH_SALES.PUBLIC.RETAILER r 
    ON s.RETAIL_LOCATION_ID = r.RETAIL_LOCATION_ID
JOIN RUSH_SALES.PUBLIC.PRODUCT p 
    ON s.PRODUCT_ID = p.PRODUCT_ID
GROUP BY 
    s.INVOICE_DATE, r.RETAILER, r.STATE, r.REGION, 
    p.PRODUCT_NAME, s.SALES_METHOD
ORDER BY s.INVOICE_DATE;
