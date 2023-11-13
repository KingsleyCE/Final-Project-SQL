What are your risk areas? Identify and describe them.

Loss of Data - Improperly cleaning data leading to loss of important information if the data set is modified incorrectly. 
Data Validation - When data isnt properly validated, one might overlook issues leving the data set with errors.
. The database is extremely messy and inconsistent. In some cases, the city and country do not match.
2. The most reliable key was fullvisitorID, (visitID) even if it also had about 5 duplicated values.
3. The top countries with respect to revenue are USA, Israel, Australia, Canada and Switzerland.
4. The top 5 cities with respect to revenue are San Francisco, Sunnyvale, Atlanta, Palo Alto, and Tel Aviv-Yafo.
5. The top 2 product categories are Home/Apparel/Men's/Men's-T-Shirts and Home/Shop by Brand/YouTube.
6. Average time spent on the website was approximately 3hrs.
7. The month with the highest sales is August 2016.

QA Process:
Describe your QA process and include the SQL queries used to execute it.

Identify outliners and modifiy them
Identify missising value 
Validate the data 
Check for duplicate records


-- Chcking for duplicates in the fullVisitorId colum from all_sessions Table 
-- SQL query:

SELECT fullvisitorid, COUNT(*)
FROM all_sessions
GROUP BY fullvisitorid
HAVING COUNT (*) > 1;

-
SELECT COUNT(visitid), visitid FROM all_sessions
GROUP BY visitid
HAVING COUNT(visitid) > 1

