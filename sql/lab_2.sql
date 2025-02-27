--Set the worksheet context.

USE WAREHOUSE FOX_LAB_WH;
USE ROLE TRAINING_ROLE;
USE DATABASE snowbearair_db;
USE SCHEMA modeled;

-- sample of 10 members with all coulmns from the table
SELECT * 
FROM members
LIMIT 10 
;

-- provide list of the cities we have members in include the state in your resutls
SELECT DISTINCT state, city
FROM MEMBERS
ORDER BY state ASC, city ASC
;

-- Members with less than 2.5 million points are classified as Snowball Members. How many Snowball members does Snowbear Air have? What is the average age of our Snowball Members?

SELECT COUNT(member_id), AVG(age)
FROM members
WHERE points_balance < 2500000

;


--Snowbear Air is considering new destinations. Which states have 50 or more members? How many do they have? Share a screenshot of your query and results.

SELECT state, count(member_id) AS member_count
FROM members
GROUP BY state
HAVING member_count > 50 
;

-- Members with 9 million points or more are classified as Diamond Members and are eligible for special perks, including automatic class upgrades and access to Airport Executive Lounges. Provide a list of Diamond Members that includes their First and Last names, point balance, email, and home state. Order the list alphabetically by last name, beginning with A.
SELECT firstname, lastname, points_balance AS RUEDA_point_balance, email, state
FROM MEMBERS
WHERE points_balance >= 9000000
ORDER BY lastname ASC
;