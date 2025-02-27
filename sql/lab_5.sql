-- context for worksheet
USE WAREHOUSE FOX_LAB_WH;
USE ROLE training_role;
USE DATABASE GOFF;
USE SCHEMA PUBLIC;

-- 
SELECT 
o.customer_id,
o.profit, 
o.sales, 
o.order_date, 
o.sub_category, 
o.country 
FROM orders o
LEFT JOIN returns r   
    ON o.order_id = r.order_id
WHERE r.returned is NULL
    ;