Question 1: find all duplicate with visitId records

SQL Queries:

SELECT COUNT(visitid), 
visitid FROM all_sessions
GROUP BY visitid
HAVING COUNT(visitid) > 1

Answer:553



Question 2: find the total number of unique visitors (`fullVisitorID`)

SQL Queries:

SELECT 
COUNT(DISTINCT fullvisitorid) 
FROM all_sessions

Answer:14223



Question 3: find the total number of unique visitors by referring sites

SQL Queries:

SELECT 
COUNT(DISTINCT fullvisitorid) 
FROM all_sessions
WHERE channelgrouping = 'Referral'

Answer:2419



Question 4: find each unique product viewed by each visitor

SQL Queries:

SELECT DISTINCT productsku, 
fullvisitorid FROM temp_tab1
WHERE fullvisitorid IS NOT NULL

Answer:1761



Question 5: Compute the percentage of visitors to the site that actually makes a purchase

SQL Queries:
	
SELECT CONCAT(ROUND(( (SELECT COUNT(fullvisitorid)*1.0 
FROM all_sessions 
WHERE totaltransactionrevenue IS NOT NULL) / (SELECT  COUNT(fullvisitorid) 
FROM all_sessions)*100),2), '%') 
AS Percentage

Answer:0.54%
