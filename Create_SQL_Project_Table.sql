CREATE TABLE all_sessions (
		fullVisitorId numeric NOT NULL,
    	channelGrouping character varying(30),
    	time integer,
    	country text,
    	city text,
    	totalTransactionRevenue integer,
    	transactions integer,
    	timeOnSite integer,
    	pageviews integer,
    	sessionQualityDim integer,
    	date date,
    	visitId integer NOT NULL,
    	type text,
    	productRefundAmount integer,
    	productQuantity integer,
    	productPrice integer,
    	productRevenue integer,
    	productSKU character varying(30), 
    	v2ProductName text,
    	v2ProductCategory character varying(100),
    	productVariant text,
    	currencyCode text ,
    	itemQuantity  integer,
    	itemRevenue integer,
    	transactionRevenue integer,
    	transactionId text,
    	pageTitle character varying(1000),
    	searchKeyword text,
    	pagePathLevel1 character varying(30),
    	eCommerceAction_type integer,
    	eCommerceAction_step integer,
    	eCommerceAction_option character varying(30)
);

--Check ALL_SESSIONS table after importing CSV file- 
SELECT * 
		FROM all_sessions
			
---------------------------------------------------
CREATE TABLE IF NOT EXISTS public.analytics
(
    visitnumber integer,
    visitid integer,
    visitstarttime integer,
    date date,
    fullvisitorid numeric,
    userid integer,
    channelgrouping character varying(30),
    socialengagementtype character varying(30) ,
    units_sold integer,
    pageviews integer,
    timeonsite integer,
    bounces integer,
    revenue BIGINT ,
    unit_price numeric
);
--Check ANALYTICS table after importing CSV file- 
SELECT * 
		FROM analytics
		
------------------------------------------------
CREATE TABLE products(
    	SKU character varying PRIMARY KEY,
    	name text,
    	orderedQuantity integer,
    	stockLevel integer,
    	restockingLeadTime integer,
    	sentimentScore numeric,
    	sentimentMagnitude numeric
);
--Check PRODUCTS table after importing CSV file- 

SELECT * 
		FROM products

--------------------------------------------------
CREATE TABLE sales_by_sku(
    	productSKU character varying(30) PRIMARY KEY,
    	total_ordered integer
);
--Check SALES_BY_SKU table after importing CSV file- 
SELECT * 
		FROM sales_by_sku
-------------------------------------------------
CREATE TABLE sales_report(
    	productSKU character varying(30) PRIMARY KEY,
    	total_ordered integer,
    	name character varying(100) ,
    	stockLevel integer,
    	restockingLeadTime integer,
    	sentimentScore numeric,
    	sentimentMagnitude numeric,
    	ratio numeric
);
--Check SSALE_PRODUCTS table after importing CSV file- 
SELECT * 
		FROM sales_products