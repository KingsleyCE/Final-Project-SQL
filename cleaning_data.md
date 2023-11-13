What issues will you address by cleaning the data?

- Remove duplicate
- Idendify and rectify in accuracies, error durring data collection.
- Ensure consistency in data format, unit and rpresentation.
- Data nomalization.
- Improve the quality and reliability of the data.


Queries:
Below, provide the SQL queries you used to clean your data.

--Data Nomalizing Tables
UPDATE all_sessions
SET city = null
WHERE city = '(not set)' OR city = 'not available in demo dataset'

UPDATE analytics
SET unit_price = unit_price/1000000

UPDATE analytics
SET unit_price = ROUND(unit_price, 2) 


--Check for duplicates in the products table 

SELECT sku, COUNT(*)
FROM products
GROUP BY sku
HAVING COUNT (*) > 1;

--Time on site format as integer to timestamp

SELECT timeonsite, 
case when time <> 0
THEN TIME '00:00' + time *
INTERVAL '1 minute' ELSE NULL
END AS converted_time
From all_sessions;