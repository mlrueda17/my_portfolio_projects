--Business Question #1:  What state has the most stores?
SELECT s_state, COUNT(*) AS num_stores
FROM store
GROUP BY s_state
ORDER BY num_stores DESC;

--Business Question #2:  What is the average number of employees in each store?
SELECT AVG(s_number_employees) AS avg_store_employees
FROM store;

--Business Question #3:  How many stores do NOT have a manager identified -- at least in the data?
SELECT COUNT(*) AS stores_wo_managers_identified
FROM store
WHERE s_manager IS NULL;

--Business Question #4:  How many managers oversee call center staff?
SELECT COUNT (DISTINCT cc_manager) AS num_managers
FROM call_center;

--Business Question #5:  What managers oversee the most call centers?
SELECT cc_manager, COUNT(*) AS num_call_centers
FROM call_center
GROUP BY cc_manager
ORDER BY num_call_centers DESC
LIMIT 10;
