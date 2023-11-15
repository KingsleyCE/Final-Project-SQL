--Answer the following questions and provide the SQL queries used to find the answer.

--TEMPORARY TABLES WHERE CREATED TO  HELP WITH ANSWERING PROJECT QUETIONS --

--TABLE 1. 

```

CREATE TABLE temp_table1 
AS	
SELECT all_sessions.fullvisitorid, 
all_sessions.city, 
all_sessions.country, 
all_sessions.totaltransactionrevenue, 
all_sessions.v2productcategory,
all_sessions.v2productname, 
all_sessions.productsku, 
analytics.units_sold, analytics.unit_price 
FROM all_sessions
JOIN analytics 
ON all_sessions.fullvisitorid = analytics.fullvisitorid

```

--TABLE 2

```

CREATE TABLE temp_table2 AS	
SELECT 
* 
FROM all_sessions AS alls
JOIN products AS pro 
ON alls.productsku = pro.sku

```

--TABLE 3.


```
							
CREATE TABLE temp_table3 AS	
SELECT 
* 
FROM all_sessions AS alls
JOIN sales_by_sku AS sbs 
USING(productsku)

```

--TABLE 4.

```
							
CREATE TABLE temp_table4 AS	
SELECT 
* 
FROM all_sessions AS alls
JOIN sales_report AS sr 
USING(productsku)

```
    
**Question 1: Which cities and countries have the highest level of transaction revenues on the site?**


--SQL Queries: 

```

i.(Countries with the highest level of transaction revenues)
SELECT country, ROUND(SUM(totaltransactionrevenue),2) AS TotalRevCountry
FROM all_sessions
WHERE city IS NOT null AND totaltransactionrevenue IS NOT null
GROUP BY country
ORDER BY TotalRevCountry DESC
LIMIT 5;

```

ii. (Cities with the highest level of transaction revenues)

```

SELECT city, country, ROUND(SUM(totaltransactionrevenue), 2) AS TotalRevCity
FROM all_sessions
WHERE city IS NOT null AND totaltransactionrevenue IS NOT null
GROUP BY city, country
ORDER BY TotalRevCity DESC
LIMIT 5;

```


--Answer: United States, Israel, Australia, Canada, Switzerland had the highest level of transaction revenues for country
	While San Francisco, Sunnyvale, Atlanta, Palo Alto, Tel Aviv-Yafo had the highest level of transaction revenues for city


**Question 2: What is the average number of products ordered from visitors in each city and country?**


SQL Queries:

--Average number of products ordered from visitors in each country?

--Query limited to top 5 countries- 

```
SELECT country, ROUND(AVG(units_sold), 2) AS avg_qty_country
FROM temp_table1
WHERE units_sold IS NOT NULL
GROUP BY country
ORDER BY avg_qty_country DESC
LIMIT 5

```

--Answer: Top 5 Average number of product includes for Country united State = 19.24, Czechia = 15.18, Mexico = 1.83, Canada = 1.59 and Bulgaria = 1.50
	Top 5 Average number of product includes San Bruno = 52.67, Mountain View = 16.17, San Jose = 8.57, Salem = 7.55 and New York = 6.90.


**Question 3: Is there any pattern in the types (product categories) of products ordered from visitors in each city and country?**


--SQL Queries:

--Pattern in the types (product categories) of products ordered from visitors in each country

```

SELECT country, v2productcategory, 
COUNT(v2productcategory) AS prd_cat_country
FROM temp_table1
WHERE country IS NOT null  
GROUP BY country, v2productcategory
ORDER BY prd_cat_country DESC
limit 50

```

--Pattern in the types (product categories) of products ordered from visitors in each city 

```

SELECT city, country, v2productcategory, COUNT(v2productcategory) AS prd_cat_city
FROM temp_table1
WHERE city IS NOT null  
GROUP BY city, country, v2productcategory
ORDER BY prd_cat_city DESC
limit 50

```

Answer: highest orders are in the United States and in the Mountain View city 
	most popular product category ordered in United States and Mountain View city is the Home/Apparel/Men's/Men's-T-Shirts/
	A total of 3 product categories per country are; (1) Home/Apparel/Men's/Men's-T-Shirts/, (2) Home/Electronics/ and, (3) Home/Shop by Brand/YouTube/ all from the united 	state.
	Also 3product categories per city are; (1) Home/Apparel/Men's/Men's-T-Shirts/, (2) Home/Nest/Nest-USA/ and, (3) Home/Electronics/. They are all in the Mountain View 	city in United States.



**Question 4: What is the top-selling product from each city/country? Can we find any pattern worthy of noting in the products sold?**


--SQL Queries:

--Top-selling product from each country?And pattern worthy of noting in the products sold?


```

WITH ranked_products AS (
SELECT country,
v2productname AS top_selling_product,
SUM(orderedquantity) AS max_qty_country,
    RANK() OVER (PARTITION BY country ORDER 
BY SUM(orderedquantity) DESC) AS product_rank
FROM temp_table2
WHERE country IS NOT NULL AND 
orderedquantity IS NOT NULL AND 
v2productname IS NOT NULL AND
country != '(not set)'
GROUP BY country, v2productname
)
SELECT country, top_selling_product,
max_qty_country
FROM ranked_products
WHERE product_rank = 1;

```

--Top-selling product from each city?And pattern worthy of noting in the products sold?

```

WITH CTE AS 
(
	SELECT city, country, v2productname AS top_selling_product, 
	SUM(orderedquantity) AS max_qty_city
	FROM temp_table2
	WHERE city IS NOT NULL AND country IS NOT null AND orderedquantity IS NOT NULL
	GROUP BY city, country, v2productname
	ORDER BY max_qty_city DESC
),
RankedTable 
AS(
SELECT city, country, top_selling_product, max_qty_city,
RANK() OVER (PARTITION BY city 
ORDER BY max_qty_city DESC) AS rannk FROM CTE
)
SELECT * FROM RankedTable 
WHERE rannk = 1

```

Answer: Google Kick Ball was the top selling product in country, Sold 364080 in United State
	Google Kick Ball was the top selling product in cities, Sold 30340 in Ney york, City of Chicago, San francisco




**Question 5: Can we summarize the impact of revenue generated from each city/country?**

--SQL Queries:

--1. Impact of revenue generated from each COUNTRY

```

SELECT country, SUM(totaltransactionrevenue) AS Total_Sum1 
FROM all_sessions
WHERE city IS NOT null AND totaltransactionrevenue IS NOT NULL
GROUP BY country 
ORDER BY Total_Sum1 DESC

```

SELECT country, MAX(totaltransactionrevenue) AS Total_Max1
FROM all_sessions
WHERE city IS NOT NULL AND totaltransactionrevenue IS NOT NULL
GROUP BY country 
ORDER BY Total_Max1 DESC

```

SELECT country, MIN(totaltransactionrevenue) AS Total_Min1
FROM all_sessions
WHERE city IS NOT NULL AND totaltransactionrevenue IS NOT NULL
GROUP BY country 
ORDER BY Total_Min1 DESC

```

SELECT country, AVG(totaltransactionrevenue) AS Avg_Total1
FROM all_sessions
WHERE city IS NOT NULL AND totaltransactionrevenue IS NOT NULL
GROUP BY country 
ORDER BY Avg_Total1 DESC

```

--2. Impact of revenue generated from each CITY

```

SELECT city, country, 
SUM(totaltransactionrevenue) AS Total_Sum2 
FROM all_sessions
WHERE city IS NOT NULL 
AND totaltransactionrevenue IS NOT NULL
GROUP BY city, country
ORDER BY Total_Sum2 DESC

```

SELECT city, country, 
MAX(totaltransactionrevenue) AS Total_Max2
FROM all_sessions
WHERE city IS NOT NULL 
AND totaltransactionrevenue IS NOT NULL
GROUP BY city, country 
ORDER BY Total_Max2 DESC

```

```

SELECT city, country, 
MIN(totaltransactionrevenue) AS Total_Min2
FROM all_sessions
WHERE city IS NOT NULL 
AND totaltransactionrevenue IS NOT NULL
GROUP BY city, country 
ORDER BY Total_Min2 DESC

```

```

SELECT city, country, 
ROUND (AVG(totaltransactionrevenue),2) AS Avg_Total2
FROM all_sessions
WHERE city IS NOT null 
AND totaltransactionrevenue IS NOT NULL
GROUP BY city, country
ORDER BY Avg_Total2 DESC

```


--Answer:In summary with respect to Country - United States, Israel, Australia, Canada, Switzerland are the 5 top countries in terms of total revenue generated.--
--Israel, Australia, United States, Canada, Switzerland are 5 top countries in terms of average revenue generated.--
--United States had the highest revenue, but Israel generated the highest average revenue, meaning visitors from Israel spent more money on the site not withstanding the lower 	peopple visotor count.--

--In summary with respect to city - San Francisco, Sunnyvale, Atlanta, Palo Alto, Tel Aviv-Yafo are the 5 top countries in terms of total revenue generated.
--Tel Aviv-Yafo, Atlanta, Sydney, Seattle, Sunnyvale  are 5 top countries in terms of average revenue generated.
--Despite San Francisco in the United States generating the highest revenue, Tel Aviv-Yafo in Israel actually generated the highest average revenue. This means,considering how 	many people visited the site from both cities, on average, visitors from Tel Aviv-Yafo spent more money on the site.
--Seattle in the United States, and Sydney in Australia, not part of the top 5 cities in terms of revenue generated, both feature in the top 5 cities based on 	average revenue 	generated because on average they had a lesser amount of visitors that generated their total revenue

