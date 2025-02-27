USE WAREHOUSE FOX_LAB_WH;
USE ROLE TRAINING_ROLE;
USE DATABASE SNOWBEARAIR_DB;
USE SCHEMA PROMO_CATALOG_SALES;
-- highest order by customer name 
SELECT c.c_firstname, c.c_lastname, o.o_totalprice 
FROM orders o
INNER JOIN customer c
 ON o.o_custkey = c.c_custkey
ORDER BY o.o_totalprice DESC
LIMIT 10
;

-- provide name with 5 countries with most customers
SELECT n.n_name, count(c.c_custkey) AS total_customers
FROM customer c
LEFT JOIN nation n
 ON c.c_nationkey = n.n_nationkey
GROUP BY n.n_name
ORDER BY total_customers DESC  
LIMIT 5
;


--Marketing wants to send thank you gifts to the 100 customers who placed the most orders in 2017. Provide the first and last names, and how many orders they each placed in 2017, ordered from most orders to least.

--Write a query to answer this request, export your results to a CSV file, and upload it here.


SELECT c.c_firstname, c.c_lastname, COUNT(o.o_custkey) AS total_orders
FROM customer c
LEFT JOIN orders o 
 ON c.c_custkey = o.o_custkey 
WHERE year(o.o_orderdate) = 2017
GROUP BY c.c_custkey, c.c_firstname, c.c_lastname
ORDER BY total_orders DESC
LIMIT 100;









