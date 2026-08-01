/*Project :  Online Retail Sales Analysis,
Objective :  Perform a complete data quality audit before business analysis,
Dataset   :  Online Retail Transactions (541,909 rows),
Analyst   :  Gopi Aneesh.
*/
/* PHASE 1: DATA EXPLORATION--
   Row count
   Column checks
   Date range
   Basic data understanding */


create database online_retail;
use online_retail;
select count(*) from retail_data;
-- Observation: Dataset contains 541,909 transaction records.
select *
from retail_data
limit 10 ;

describe retail_data;

-- Missing Values--

select 
      count(*) AS Total_rows,
      sum(invoiceno is null ) AS Null_invoiceno,
      sum(stockcode is null) AS Null_stockcode,
      sum(description is null) AS Null_description,
      sum(quantity is null) As null_quantity,
      sum(invoicedate is null) AS null_invoice_date,
      sum(unitprice is null) AS Null_unitprice,
      sum(customerid is null) AS null_customerid,
      sum(country is null) As null_country
from retail_data ;

 select sum(duplicate_rows -1) as duplicate_rows 
from (
       select count(*) AS Duplicate_rows
       from retail_data
       group by invoiceno,stockcode,description,quantity,invoicedate,unitprice,customerid,country
       having count(*) > 1
       ) AS Duplicates;
       
select invoiceno,
		stockcode,
		description,
		quantity,
		invoicedate,
		unitprice,
		customerid,country,
count(*) AS dupicate_count
from retail_data 
group by invoiceno,
         stockcode,
         description,
         quantity,
         invoicedate,
         unitprice,
         customerid,
         country
having count(*) > 1 
limit 10 ;

select * from retail_data
where quantity <0 
limit 10;

select count(*) AS Negative_rows
from retail_data 
where quantity < 0;

select count(*) AS cancled_invoice 
from retail_data 
where invoiceno like 'c%';

select count(*) AS Negative_zeroprice 
from retail_data
where unitprice <= 0;
 
select min(invoicedate) AS First_date,
	   max(invoicedate) AS Second_date
from retail_data;

select invoicedate
from retail_data
where year(invoicedate)  > '2030' 
limit 5 ;

select count(*)
from retail_data 
where year(invoicedate) > '2030';

select distinct year(invoicedate) AS Year
from retail_data;

select   count(*),
         year(invoicedate) AS no_of_records
from retail_data
group by no_of_records;

select
       min(date(invoicedate)) AS Earliest_date,
       max(date(invoicedate)) AS Latest_date
from retail_data 
order by earliest_date ASc ,  latest_date desc 
limit 10 ;

select    invoiceno, 
         date(invoicedate) AS orginal_invoicedate ,
         year(invoicedate) AS extracte_invoiceyear
from retail_data 
where year(invoicedate) in ('2001', '2031')
order by extracte_invoiceyear desc
limit 10;

select 
      count(*)
from retail_data 
where date(invoicedate) = '2031-10-11';

select 
       invoiceno,
       customerid,
       invoicedate
from retail_data
where date(invoicedate) = '2031-10-11'
limit 20;

select invoicedate ,
       min(invoiceno) AS earliest_invoice,
       max(invoiceno) AS latest_invoice 
from retail_data
group by invoicedate
order by earliest_invoice ASC , latest_invoice desc 
limit 20;

select 
      customerid,
	  date(invoicedate) AS date_invoice,
	  max(invoiceno) AS Highest_invoice_number
from retail_data
group by customerid,invoicedate
order by Highest_invoice_number desc 
limit 20;

select 
       count(*) AS No_of_records,
       month(invoicedate) AS Invoice_month,
       year(invoicedate) AS Invoice_year
from retail_data
group by invoice_month,invoice_year;
     
select 
       distinct year(invoicedate) AS invoice_year ,
       count(*) AS No_of_transctions
from retail_data 
group by invoice_year
order by Invoice_year asc ;

select 
        date(invoicedate) AS corresponding_dates,
        min(invoiceno) AS Lowest_invoiceno,
        max(invoiceno) AS highest_invoiceno
from retail_data
group by corresponding_dates
order by Lowest_invoiceno asc , highest_invoiceno desc 
limit 20;

select  
       invoiceno , 
	   invoicedate
from retail_data 
order by invoiceno desc 
limit 10 ;

select 
       invoiceno , 
       invoicedate 
from retail_data
order by invoiceno asc 
limit 10;

select distinct 
       Date(invoicedate) AS Unique_date,
	   Time(invoicedate) AS Time_stamp
from retail_data;

select 
       distinct count(*) AS Unique_count,
                date(invoicedate) AS Invoice_date
from retail_data
group by Invoice_date;

select 
       invoiceno ,
       date(invoicedate) AS Invoice_date
from retail_data;

select 
      invoiceno,
      count(distinct date(invoicedate)) AS unique_invoice_count
from retail_data
group by Invoiceno;  

select 
       invoiceno,
	   count(distinct date(invoicedate)) AS Unique_invoice_count
from retail_data 
group by invoiceno
having Unique_invoice_count > 1 ;

select
       count(distinct(customerid)) AS Unique_customer_count
from retail_data;

select 
      count(*)AS Transactions ,
      customerid AS no_of_customers
from retail_data
group by no_of_customers;

select
        count(*)AS Unique_count,
        customerid 
from retail_data
where customerid is not null and customerid <>''
group by customerid
order by Unique_count desc 
limit 20;

select 
       customerid,
       round(sum(quantity*unitprice),2) AS Highest_revenue
from retail_data
where customerid is not null and customerid <>''
group by customerid 
order by Highest_revenue desc 
limit 20 ;

select 
       customerid,
       round(avg(quantity*unitprice),2) AS Avg_spending_customer
from retail_data
where customerid is not null and customerid <>''
group by customerid
order by Avg_spending_customer desc 
limit 20;

select 
	  customerid,
      count(distinct(country))  AS unique_country
from retail_data 
where customerid is not null and customerid<>''
group by customerid
order by unique_country desc
limit 20;

select 
	   customerid,
       min(date(invoicedate)) AS first_invoice,
       max(date(invoicedate)) AS last_invoice_date 
from retail_data
where customerid is not null and customerid<>''
group by customerid
order by first_invoice Asc , last_invoice_date desc 
limit 20;

select 
       count(distinct(stockcode)) AS unique_product
from retail_data;

select
      stockcode ,
      sum(quantity) AS sold_products
from retail_data
group by stockcode 
order by sold_products desc 
limit 10;

select 
	   stockcode,
       round(sum(quantity*unitprice),2) AS Top_products_by_revenue
from retail_data
where stockcode not in ('dot','post')
group by stockcode
order by Top_products_by_revenue desc 
limit 20;

select
        stockcode,
        round(avg(unitprice),2) AS Avg_product_price
from retail_data
where stockcode not in ('dot','postage')
group by stockcode
order by Avg_product_price desc 
limit 50;

select 
       stockcode,
	   count(distinct(customerid)) AS Unique_custoemrs
from retail_data
where customerid is not null and customerid <>''
group by stockcode
order by Unique_custoemrs desc 
limit 20;

select 
        count(distinct(country)) AS Unique_country
from retail_data ;

select 
       country ,
       count(*) AS Highest_count
from retail_data 
group by country
order by Highest_count desc 
limit 40 ;

select 
       country,
	   round(sum(quantity*unitprice),2) AS Highest_revenue
from retail_data
group by Country
order by Highest_revenue desc ;

select 
       country , 
       round(Avg(quantity*unitprice),2) AS Avg_transaction_value
from retail_data
group by Country
order by Avg_transaction_value desc ;

select 
        country,
        count(distinct(customerid)) AS No_of_customers
from retail_data
where customerid is not null and customerid <>''
group by country
order by No_of_customers desc ;

select 
       country,
       count(distinct (invoiceno)) AS NO_of_invoice
from retail_data
group by Country
order by NO_of_invoice desc ;

select 
       count(distinct(invoiceno)) AS Canclled_orders
from retail_data
where left(invoiceno,1) ='c' ;

select 
       count(*) AS Unique_count
from retail_data
where left(invoiceno,1) = 'c';

select 
       invoiceno,
       round(sum(quantity*unitprice),2) AS Canclled_revenue
from retail_data
where left(invoiceno,1) = 'C'
group by Invoiceno
order by Canclled_revenue desc
limit 20;


select 
       invoiceno,
       round(sum(quantity),2) AS Total_returned_quantity
from retail_data
where left(invoiceno,1) = 'C'
group by invoiceno
order by Total_returned_quantity desc
limit 20 ;

select 
        stockcode,
        round(sum(quantity),2) AS Total_return_quantity
from retail_data
where left(invoiceno,1) = 'c' 
and stockcode not in  ('dot','post','Amazonfee')
group by Stockcode
order by Total_return_quantity desc 
limit 20 ;

/* PHASE 2: BUSINESS ANALYSIS -- 
   
   Customer Analysis 
   Product Analysis
   Country Analysis
   Time Analysis    */

-- Who are the most frequent customers?
select 
       customerid,
       count(distinct(invoiceno)) AS Number_of_orders_per_customer,
	   round(sum(quantity*unitprice)) AS Revenue_per_customer
from retail_data
where customerid is not null and customerid <>''
group by customerid 
order by Number_of_orders_per_customer desc,
         Revenue_per_customer desc 
limit 20;

-- How many customers are loyal repeat buyers compared to customers who purchased only once?

select 
       case
            when count(distinct invoiceno) = 1 then 'one Time customer'
            else 'Repate Customers'
            end AS customer_type,
            count(*) AS No_of_customers
from retail_data
where customerid is not null 
and customerid <>''
group by customerid 
order by No_of_customers desc
limit 20;

-- Which customers generate the most value for the business over their relationship period?
select 
	customerid ,
			 round(sum(quantity*unitprice),2) AS Total_revenue,
             min(date(invoicedate)) AS first_purchase_date,
             max(date(invoicedate)) AS Last_purchase_date,
	         datediff(max(date(invoicedate)),min(date(invoicedate))) AS Difference_purchase_date
from retail_data
where customerid is not null 
and customerid <>'' 
group by Customerid
order by 
        Total_revenue desc ,
                   first_purchase_date desc ,
		Last_purchase_date desc,
                   Difference_purchase_date desc 
limit 20 ;
       
-- Which customers have not purchased recently?
select 
      customerid,
	           max(
		            date(invoicedate)
)AS Last_purchase_date,
     datediff(
	          (select max(date(invoicedate)) from retail_data) ,
                max(date(invoicedate))
)AS Day_since_purchase
from retail_data
where customerid is not null 
and customerid <>''
group by Customerid
order by Last_purchase_date asc,Day_since_purchase desc;

-- Classify customers into one-time customers and repeat customers.
with 
     customer_segment AS 
(
  select
        customerid,
		          case
				  when count(distinct invoiceno) = 1 then 'Onetimecustomer'
                  else 'Repate_customer'
		          end as Customer_type
from retail_data
where customerid is not null and customerid<>''
group by Customerid 
)
select 
        customer_type,
        count(*) AS No_of_customers
from customer_segment
group by Customer_type ;

  -- How much does each customer spend per order on average? 
  
with 
     invoice_sales AS
(  
  select 
         customerid,
         invoiceno,
		 round(sum(quantity*unitprice),2) AS Invoice_total
from retail_data
where customerid is not null and customerid <>''
group by Customerid,invoiceno
)
select
       customerid,
       round(avg(Invoice_total),2)AS AVG_order_value
from invoice_sales
group by customerid
order by AVG_order_value desc ;
  
-- How does customer revenue change month by month?

select 
       month(invoicedate) AS Monthly_sales,
       year(invoicedate) AS Yearly_sales,
	   round(sum(quantity*unitprice),2) AS monthly_revenue
from retail_data
group by month(invoicedate), year(invoicedate)
ORDER BY Yearly_sales ASC, Monthly_sales ASC ;
  
-- Which customers contribute the highest percentage of total revenue?

with 
     highest_revenue AS 
(
   select
           customerid,
           round(sum(quantity*unitprice),2) AS Total_revenue
from retail_data
where customerid is not null and customerid <>''
group by Customerid 
)
select 
	   customerid,
       total_revenue,
       round(Total_revenue/(select sum(total_revenue) from highest_revenue),2)AS Revenue_contributer
from highest_revenue
order by revenue_contributer desc 
limit 20;

-- Which customers have the highest purchase frequency?

select 
       customerid,
       count(distinct invoiceno) AS Highest_frequency
from retail_data
where customerid is not null 
and customerid <>''
group by Customerid
order by Highest_frequency desc 
limit 20;

-- Which customers have not purchased recently?

select 
       customerid,
       max(date(invoicedate)) AS Max_invoicedate,
       datediff
       ((select
                max(date(invoicedate)) From retail_data),
				max(date(invoicedate))) as Not_purchased_recently
from retail_data 
where customerid is not null and customerid<>''
group by customerid
order by Not_purchased_recently desc 
limit 20;

-- How many products does each customer buy on average per order?

with 
     Highest_product_order AS 
(
  SELECT 
        customerid ,
        invoiceno,
        round(SUM(quantity),2) AS Total_product_per_order
FROM retail_data
WHERE customerid IS NOT NULL 
AND customerid <> ''
GROUP BY customerid, invoiceno
)
 select
        customerid,
        round(Avg(Total_product_per_order),2)  AS Average_per_order
from Highest_product_order 
group by customerid
order by Average_per_order desc ;

-- What is the average number of items purchased per order by each customer, excluding cancelled orders?

with 
     Highest_orders AS
 (
   select 
          customerid,invoiceno,
	      round(sum(quantity),2)  AS Total_order_quantity
from retail_data
where customerid is not null and customerid <>''
and left(invoiceno,1) <> 'C'
and quantity > 0
group by customerid,invoiceno
)
select 
       customerid,
	   round(Avg(Total_order_quantity),2) AS Average_per_order
from Highest_orders
group by Customerid
order by Average_per_order desc 
limit 20;

-- Which customers have the highest average order value?

with
     highest_order_value AS 
(
 select 
          customerid,
		  invoiceno,
          round(sum(quantity*unitprice),2) AS Total_highest_value 
from retail_data
where customerid is not null 
and customerid <>''
and left(invoiceno,1) <> 'C'
and quantity >0
group by customerid,invoiceno 
)
select 
       customerid,
	   round(avg(Total_highest_value),2) AS Average_order_value
from highest_order_value
group by Customerid
order by Average_order_value desc 
limit 20 ;

-- Which customers have the highest total number of orders and highest average order value?

with 
     High_orders AS 
(
  select 
        customerid,
        invoiceno,
        round(sum(quantity*unitprice),2) AS Total_no_of_orders
from retail_data
where customerid is not null 
and customerid <>''
and left(invoiceno,1) <> 'C'
and quantity > 0
group by customerid,invoiceno
)
 select 
        customerid,
        count(invoiceno) AS Unique_count,
        round(avg(Total_no_of_orders),2) AS Avg_per_order
from High_orders
group by customerid
order by Unique_count desc , Avg_per_order desc 
limit 20;

-- Which countries generate the highest total revenue?"

 select 
        country,
        round(sum(quantity*unitprice),2) AS Highest_total_revenue
from retail_data
group by country
order by Highest_total_revenue desc ;

-- Which products generate the highest revenue?
select 
       stockcode,
	   round(sum(quantity*unitprice),2) AS Highest_revenue
from retail_data
where stockcode not in  ('dot','post')
group by stockcode
order by Highest_revenue desc 
limit 20;

-- Which products are sold in the highest quantity?

select 
       stockcode,
       round(sum(quantity),2) AS Highest_quantity
from retail_data
where stockcode not in ('DOT','POST')
and quantity > 0
group by stockcode
order by Highest_quantity desc 
limit 20;

-- Which products have the highest average selling price?
select 
        stockcode,
        round(Avg(unitprice),2) AS Highest_avg_selling_price
from retail_data
where stockcode not in ('AMAZONFEE','CRUK','M','BANK CHARGES','DOT','POST','SHIP')
group by Stockcode
order by Highest_avg_selling_price desc 
limit 20;

-- Which products are purchased by the most customers?
select 
        stockcode,
        round(count(distinct customerid),2) AS purchased_customers 
from retail_data
where customerid is not null 
and customerid <>''
and stockcode not in ('AMAZONFEE','CRUK','M','BANK CHARGES','DOT','POST','SHIP')
and right(stockcode,1) <> 'A'
group by stockcode
order by purchased_customers  desc 
limit 20 ;

-- Which months generate the highest revenue?
select
       year(invoicedate) AS Yearly_sales,
       month(invoicedate) AS Monthly_sales,
	   round(sum(quantity*unitprice),2) AS Highest_revenue
from retail_data
group by year(invoicedate)  , month(invoicedate) 
order by   Highest_revenue desc ;

-- Which years generate the highest revenue?
select 
       year(invoicedate) AS Yearly_sales,
       round(sum(quantity*unitprice),2) AS Highest_revenue
from retail_data
group by Yearly_sales
order by Highest_revenue asc
limit 20 ;

-- Which months have the highest number of orders?
select 
      year(invoicedate) AS yearly_sales,
      month(invoicedate) AS Monthly_sales,
      round(count(distinct invoiceno),2) AS Unique_count
from retail_data
group by yearly_sales , monthly_sales
order by unique_count desc 
limit 20 ;

-- Which countries have the highest number of orders?
select 
       country , 
	   count(distinct invoiceno) AS Highest_orders
from retail_data
group by Country
order by Highest_orders desc ;

-- Which countries generate the highest revenue?
select 
       country , 
	   round(sum( quantity*unitprice),2) AS Total_revenue
from retail_data
group by Country
order by  Total_revenue desc ;

-- Which countries have the highest average order value?

with
     Highest_orders AS 
(
  select
        country, 
        invoiceno,
		round(sum(quantity*unitprice),2) AS Total_order_value
from retail_data
group by Country,invoiceno
)
select
       Country,
       round(Avg(Total_order_value),2) AS Average_order_value
from Highest_orders
Group by Country
order by Average_order_value desc ;

-- Which countries have the highest average quantity per order?
with 
    order_quantity AS
 (
   select
         country ,
         invoiceno,
         round(sum(quantity),2) AS Total_quantity_per_order
from retail_data
group by Country,Invoiceno
)
 select
        country,
        round(Avg(Total_quantity_per_order),2) AS Highest_average_quantity_per_order
from order_quantity
group by Country
order by Highest_average_quantity_per_order desc;

-- Which countries have the highest number of customers?
select 
      country,
	  count(distinct customerid) AS Highest_no_of_customers
from retail_data
where customerid is not null 
and customerid <>''
group by Country
order by Highest_no_of_customers desc ;


-- Which countries have the highest repeat customers?"

with
     Customer_orders AS 
(
  select 
         country ,
         customerid,
         count(distinct invoiceno) AS Total_orders
from retail_data
where customerid is not null 
and customerid <> ''
group by Country,Customerid
)
select 
       country,
	   count(customerid) AS Repeat_customers 
from Customer_orders
where Total_orders > 1
group by Country 
order by Repeat_customers desc ;

-- Which customers have the highest purchase frequency?

select
         Customerid,
         count(distinct invoiceno )AS Highest_purchase_frequency
from retail_data
where customerid is not null
and Customerid <>''
group by Customerid
order by Highest_purchase_frequency desc 
limit 20;

-- Which customers generate the highest revenue?

 select 
        customerid,
		round(sum(quantity*unitprice),2) AS Total_Revenue
from retail_data
where Customerid is not null 
and customerid <>''
group by Customerid
order by Total_Revenue desc 
limit 20 ;
  
-- Which customers have the highest average order value?

with 
     Highest_order AS 
(
  select 
        customerid,
        invoiceno,
        round(sum(quantity*unitprice),2) AS Total_order_value
from retail_data
where customerid is not null 
and customerid <>''
group by Customerid,Invoiceno
)
select 
       Customerid,
       round(Avg(Total_order_value),2) AS Avg_order_value
from Highest_order
Group by Customerid
order by Avg_order_value desc
limit 20 ;
  
-- Which customers buy the highest number of different products?

select
       Customerid , 
       count(distinct stockcode) AS Unique_products
from retail_data
where Customerid is not null 
and customerid<> ''
and left(invoiceno,1) <> 'c'
and quantity > 0
Group by customerid
order by Unique_products desc 
limit 20 ;

-- Which customers have the highest average number of products per order?

with 
     Customer_orders AS 
(
  select 
        customerid,
		invoiceno,
		round(sum(quantity),2) AS Total_orders
from retail_data
where customerid is not null 
and customerid <>''
and left(invoiceno,1) <> 'c'
and quantity > 0
group by customerid , invoiceno
)
  select 
         Customerid,
         round(avg(Total_orders),2) AS Average_orders
from customer_orders
group by Customerid
order by Average_orders desc 
limit 20 ;
  
/*
PHASE 3: DATA CLEANING
   - Created Retail_Cleaned table
   - Identified exact duplicate records
   - Removed 5,187 duplicate rows
   - Removed cancelled invoice transactions
   - Created Retail_Final table
   - Validated final dataset quality
*/
   
-- Find total number of records before cleaning.
select 
      count(*)
from retail_data;

-- Find cancelled transaction records.
select 
	   invoiceno 
from retail_data
where left(invoiceno,1)  = 'c';

select
        count(invoiceno) AS Canclled
from retail_data
where left(invoiceno,1) = 'C';

-- Find negative quantity records. 
select 
       count(quantity) AS Negative_records
from retail_data
where quantity < 0;

-- Find how many records have invalid UnitPrice values.
select 
       count(unitprice) AS invalid_unit_price 
from retail_data 
where unitprice <= 0 ;

-- Find missing customer information
select
	   count(*) AS Missing_customer_information  
from retail_data
where customerid is null;

-- Find missing customer information
select 
      count(*) AS Missing_customer_information 
from retail_data
where customerid = '' ;

/*Write the SQL query to create the cleaned dataset.
Cancelled invoices    :         Remove invoices where InvoiceNo starts with "C"
Quantity              :         Remove negative quantities
UnitPrice             :         Remove invalid prices (<=0)
CustomerID            :         Remove null and ''
*/
create table Retail_cleaned AS 
select *
From Retail_data 
where left(invoiceno,1) <>  'C'
and quantity >0
and unitprice > 0 
and customerid is not null
and customerid <> '' ;
 
 select
        count(*) AS Unique_count
from retail_cleaned;

select 
       count(invoiceno) AS Count
from retail_cleaned 
where left(invoiceno,1) = 'c';

select 
       count(quantity) AS unique_count
from retail_cleaned 
where quantity < 0;

select 
       count(unitprice) AS Unique_count
from retail_cleaned 
where unitprice <= 0 ;

select 
       count(customerid) AS Unique_count
from retail_cleaned 
where customerid = '';

SELECT  
       COUNT(*) AS Missing_customerid
FROM retail_cleaned
WHERE customerid IS NULL;

select 
       distinct stockcode
from retail_data;

select 
       Distinct stockcode
from retail_data 
where stockcode regexp '[A-Za-z]';

SELECT 
       DISTINCT stockcode
FROM retail_data
WHERE stockcode REGEXP '^[A-Za-z]+$';

select
	   stockcode ,
       Description,
	   count(*) AS Records
from retail_data 
where stockcode regexp '^[A-Za-z]+$'
group by Stockcode,Description 
order by records desc ;

drop table 
retail_cleaned ;
/*Write the SQL query to create the cleaned dataset.
Cancelled invoices    :         Remove invoices where InvoiceNo starts with "C"
Quantity              :         Remove negative quantities
UnitPrice             :         Remove invalid prices (<=0)
CustomerID            :         Remove null and ''
stockcode             :         remove unwanted letters 
*/
create table Retail_Cleaned AS 
select 
	  *
From Retail_data 
where left(invoiceno,1) <>  'C'
and quantity >0
and unitprice > 0 
and customerid is not null
and customerid <> '' 
and stockcode not in  ('POST','DOT','M','D','S','AMAZONFEE','CRUK','B');
 
select
       stockcode
from retail_cleaned 
where stockcode regexp '^[A-Za-z]+$';

select
       stockcode,
       count(*)AS records 
from retail_cleaned 
where stockcode in ('POST','DOT','M','D','S','AMAZONFEE','CRUK','B')
group by Stockcode
 order by records desc ;
/* Find original record count
   Cleaned record count
    Percentage of records retained after cleaning */
    
select
      (select count(*)from Retail_data) AS Raw_data,
      (select count(*)from Retail_cleaned ) AS Cleaned_data,
      (select count(*)from retail_cleaned)/
      (select count(*)from retail_data)*100 AS Rentititon_Percentage;

select 
       min(invoicedate) AS Earliest_date,
       max(invoicedate) AS latest_data
from retail_data;
        
select 
       year(invoicedate) AS year,
       count(*) AS Records
from retail_data
group by year(invoicedate)
order by year desc ;

select
      *
from retail_data 
where year(invoicedate) in ( '2001' ,'2031')
limit 40;

select 
       day(invoicedate) AS days,
       month(invoicedate) AS Months,
       year(invoicedate) AS Years
from retail_data
group by days,months,years
order by days desc ,months desc ,years desc ;
 
select 
	  min(date(invoicedate)) AS earliestdate,
	  max(date(invoicedate)) AS Latest_date
from retail_data ;

select 
       year(invoicedate) AS years,
	   month(invoicedate)AS months,
       count(*) AS Records
from retail_data 
group by  years , months 
order by  years desc , months desc ;

select 
       year(invoicedate) AS years 
from retail_cleaned 
group by years
order by years desc ;

select 
      year(invoicedate) AS years,
	  count(*) AS No_of_Records 
from retail_cleaned 
group by years 
order by years desc ;

select
       max(year(invoicedate)) AS Maximum_year,
	   max(date(invoicedate)) AS Maximum_date
from retail_cleaned ;

select
       min(year(invoicedate)) AS Min_year,
	   min(date(invoicedate)) AS Min_date
from retail_cleaned ;

select 
       invoiceno ,
	   year(invoicedate) AS years
from retail_cleaned 
where year(invoicedate) in ('2001', '2031')
group by invoiceno,year(invoicedate)
order by years asc 
limit 20;

select 
       invoiceno,
	   country ,
       date(invoicedate) AS dates 
from retail_cleaned 
where year(invoicedate) = '2001'
limit 10;

select 
        invoiceno ,
        country , 
	    date(invoicedate) AS Dates
from retail_cleaned 
where year(invoicedate) = '2031'
limit 10 ;

select 
		date(invoicedate) AS Dates,
        max(invoiceno) AS Max,
        min(invoiceno) AS Min 
from retail_cleaned 
group by dates
limit 10;

select 
       invoiceno ,
       invoicedate 
from retail_cleaned 
group by invoiceno , invoicedate 
order by invoiceno asc 
limit 20 ;

select 
      invoiceno,
	  description,
      quantity,
      unitprice,
	  invoicedate
from retail_cleaned 
where Invoiceno = '536365'
group by invoiceno,description,quantity,unitprice, invoicedate
limit 10;

select 
       invoiceno, 
       invoicedate,
	   day(invoicedate) AS days,
	   month(invoicedate) AS month  ,
       year(invoicedate) AS year 
from retail_cleaned 
limit 100;

select 
       day(invoicedate) As days,
       date(invoicedate) AS dates,
       time(invoicedate) AS times,
	   count(distinct year(invoicedate)) AS years 
from retail_data
where year(invoicedate) in  ('2001','2031')
group by days,dates,times;

select 
       day(invoicedate) As days,
       date(invoicedate) AS dates,
       time(invoicedate) AS times,
       count(distinct year(invoicedate)) AS years 
from retail_data
group by days,dates,times
having count( year(invoicedate)) > 1;

select 
       day(invoicedate) As days,
       month(invoicedate) AS months, 
       time(invoicedate) AS times,
       count(distinct year(invoicedate)) AS years 
from retail_data
group by days,months,times 
having count( year(invoicedate)) > 1
order by years desc 
limit 40;
      
select 
	     (year(invoicedate)) AS years,
         count(*) AS Records 
from retail_data 
group by years
order by years desc ;

select 
       year(invoicedate)AS years,
       min(invoiceno) As Minimum_invoice,
       max(invoiceno) AS Max_invoice
from retail_data 
group by  year(invoicedate)
order by years desc ;

select 
       invoiceno,
       StockCode,
       Description,
       Quantity,
       InvoiceDate,
       UnitPrice,
       CustomerID,
       Country,
       count(*) AS Duplicate_count
from retail_cleaned 
group by invoiceno,StockCode,Description,Quantity,InvoiceDate,UnitPrice,CustomerID,Country
having  count(*) > 1
order by duplicate_count desc 
limit 20;

select 
       count(*) AS Duplicate_count
from retail_cleaned ;


select 
       sum(duplicate_count - 1 ) AS extra_Duplicate_rows 
from 
(
  select 
		invoiceno,
		stockcode,
        Description,
        Quantity,
        InvoiceDate,
        UnitPrice,
        CustomerID,
        Country,
        count(*) AS duplicate_count
from retail_cleaned 
group by invoiceno,stockcode,Description,Quantity,InvoiceDate,UnitPrice,CustomerID,Country
having count(*) > 1
) AS duplicates ;

create table Retail_final AS 
select 
      distinct *
From retail_cleaned;

select 
       invoiceno,
       stockcode,
       description,
       quantity,
       invoicedate,
       unitprice,
       customerid,
       country,
	   count(*) AS duplicate_count
from retail_final
group by invoiceno , stockcode,description,quantity,invoicedate,unitprice,customerid,country
having count(*) > 1;

select 
       invoiceno 
from retail_final
where left(invoiceno,1) = 'c';

select 
       customerid
from retail_final
where customerid is null;

select 
       customerid 
from retail_final
where customerid = '' ;

/*
PHASE 4: EXPLORATORY DATA ANALYSIS (EDA)

   - Analysing final cleaned dataset
   - Understanding transaction patterns
   - Calculating revenue metrics
   - Analysing customer behaviour
   - Analysing product performance
   - Analysing country performance
   - Identifying sales trends */

-- total revenue generated from Retail_Final
select 
       round(sum(quantity*unitprice),2) AS Total_revenue
from retail_final;

 -- Total number of unique orders (invoices) in Retail_Final.
select 
       count(distinct invoiceno) AS Total_numbers
from retail_final;

-- Average Order Value (AOV) for the entire business
select 
       round(sum(unitprice*quantity)/ count(distinct invoiceno),2)AS Avg_order_value
from retail_final;

-- Which invoice generated the highest revenue?

select 
       invoiceno , 
	   round(sum(quantity*unitprice) ,2) AS Highest_revenue
from retail_final
group by invoiceno
order by highest_revenue desc 
limit 20;

--  customer generates the highest revenue?

select 
      customerid,
      round(sum(quantity*unitprice),2) AS Highest_revenue
from retail_final
group by customerid
order by Highest_revenue desc 
limit 20;

-- Which customer placed the highest number of orders?

select 
      customerid,
	  count(distinct invoiceno ) AS Highest_orders
from retail_final
group by Customerid
order by Highest_orders desc 
limit 20 ;

-- Which product generated the highest revenue?

select 
       stockcode,
       description,
	   round(sum(quantity*unitprice),2) AS Total_highest_revenue
from retail_final
group by Stockcode,description
order by Total_highest_revenue desc 
limit 20;

-- Which product sold the highest quantity?
select 
       stockcode,
       description,
       round(sum(quantity),2) AS Total_highest_quantity
from retail_final
group by stockcode,description
order by Total_highest_quantity desc 
limit 20 ;

-- Which product was purchased by the highest number of unique customers?

select 
       stockcode,
	   description,
	  count(distinct customerid) AS Highest_no_of_customers 
from retail_final
group by Stockcode,description 
order by Highest_no_of_customers  desc 
limit 20 ;

-- Which country generated the highest total revenue?

select 
      country, 
	 round(sum(quantity*unitprice),2) AS Total_revenue
from retail_final
group by Country
order by Total_revenue desc 
limit 20 ;

-- Which country placed the highest number of unique orders?
select 
       country,
	 count( distinct invoiceno) AS Unique_orders 
from retail_final
group by Country 
order by Unique_orders desc 
limit 20 ;

-- Which country has the highest number of unique customers?

select 
       country,
	  count(distinct  customerid ) AS Unique_customer_count
from retail_final
group by Country 
order by Unique_customer_count desc 
limit 20 ;

-- Which country has the highest average order value?

with order_value AS 
(
 select 
        country , invoiceno ,
	round(sum(quantity*unitprice),2) AS  Total_order_value 
from retail_final
group by country ,invoiceno
)
  select country , 
  round(avg(Total_order_value),2) AS Avg_ord_value
from order_value
group by Country 
order by Avg_ord_value desc ;

-- Which products have the highest average selling price?

select 
       Stockcode ,
       description,
       Round(avg(unitprice),2) AS Avg_selling_price
from retail_final
group by Stockcode , Description
order by Avg_selling_price desc
limit 20 ;

-- Which products generate the highest revenue per unit sold?
select
       stockcode,
       description,
	  round(sum(quantity*unitprice)/sum(quantity),2) AS revenue_per_unit
from retail_final
group by Stockcode,description 
order by revenue_per_unit desc 
limit 20;

-- Which month generated the highest revenue?
select
		year(invoicedate) AS Yearly_sales,
        month(invoicedate) AS Monthly_sales,
		round(sum(quantity*unitprice),2) AS Highest_revenue
from retail_final
group by Monthly_sales,Yearly_sales
order by Highest_revenue desc
limit 20;

-- Which month had the highest number of orders?
select 
      year(invoicedate) AS Yearly_orders,
      month(invoicedate) AS Monthly_orders,
      count(distinct invoiceno) AS Highest_no_of_orders
from retail_final
group by Yearly_orders,monthly_orders
order by Highest_no_of_orders desc 
limit 20 ;

-- Which day of the week receives the highest number of orders?

select 
        dayname(invoicedate) AS Week_days,
        count(distinct invoiceno) AS Highest_no_of_orders
from retail_final
group by Week_days
order by Highest_no_of_orders desc 
limit 20 ;

-- Which hour of the day has the highest number of orders?

select 
      DATE_FORMAT(InvoiceDate, '%h:%i %p') AS extracted_hour,
      count(distinct invoiceno) AS Highest_no_of_orders
from retail_final
group by extracted_hour
order by Highest_no_of_orders desc 
limit 20;

-- Which customer places the highest average order value?
with Avg_order AS 
(
 select 
        customerid,invoiceno,
        round(sum(quantity*unitprice),2) AS Total_value
from retail_final
group by Customerid,invoiceno
)
 select 
       customerid,
       round(avg(total_value),2) AS Avg_order_value
from Avg_order
group by customerid
order by Avg_order_value desc 
limit 20;

-- Which products have the highest average quantity sold per order?
with avg_orders AS
(
select 
        invoiceno,
       stockcode,
       round(sum(quantity),2) AS Total_orders
from retail_final
group by Invoiceno,stockcode
)
select 
       stockcode,
       round(avg(total_orders),2) AS Avg_order_quantity
from avg_orders 
group by stockcode
order by Avg_order_quantity desc 
limit 20 ;

-- Which customers purchased the highest number of distinct products?

select
       customerid,
       count(distinct stockcode)AS Highest_no_of_products
from retail_final
group by customerid
order by Highest_no_of_products desc 
limit 20;

-- Which customers purchased the highest total quantity of items?
select 
      customerid,
	  round(sum(quantity),2) AS Highest_quantity
from retail_final
group by Customerid
order by Highest_quantity desc 
limit 20 ;


-- Which products have the highest repeat purchase rate?
select 
       stockcode,
       count(distinct invoiceno) AS Highest_repeat_purchase 
from retail_final
group by stockcode
order by Highest_repeat_purchase  desc 
limit 20 ;

-- Which customers have the longest purchasing history?

select 
      customerid,
      min(invoicedate) AS Min_purchase,
      max(invoicedate) AS Max_purchase,
      datediff(max(invoicedate),min(invoicedate)) AS Purchasing_history 
from retail_final
group by customerid
order by Purchasing_history desc 
limit 20;

-- Which month generated the highest revenue?

select 
      year(invoicedate) AS Yearly_revenue,
      month(invoicedate) AS Monthly_revenue,
      round(sum(quantity*unitprice),2) AS Highest_revenue
from retail_final
group by yearly_revenue,monthly_revenue
order by Highest_revenue desc 
limit 20;

-- Which year generated the highest revenue?
select 
      year(invoicedate) AS Yearly_revenue,
      round(sum(quantity*unitprice),2) AS Highest_revenue
from retail_final
group by yearly_revenue
order by Highest_revenue desc 
limit 1;

-- Which month generated the highest revenue within 2011?
select 
       year(invoicedate) AS yearly_revenue,
       month(invoicedate) AS Monthly_revenue,
       round(sum(quantity*unitprice),2) AS Generated_highest_revenue
from retail_final
where year(invoicedate) = 2011
group by yearly_revenue,Monthly_revenue
order by Generated_highest_revenue asc
limit 20;

-- Which month had the highest number of unique orders in 2011?
select 
	  year(invoicedate) AS Yearly_orders,
      month(invoicedate) AS Monthly_orders,
      count(distinct invoiceno) AS Highest_no_of_orders
from retail_final
where year(invoicedate) = 2011
group by yearly_orders,monthly_orders
order by Highest_no_of_orders desc 
limit 20;
 
-- Which year had the highest number of unique customers?
select 
       year(invoicedate) AS Yealy_customers,
       count(distinct customerid) AS unique_customers
from retail_final
group by Yealy_customers
order by unique_customers desc;

-- What was the average order value in 2011 compared with 2010?
with avg_value AS (
select 
      year(invoicedate) AS Year,
      invoiceno,
      round(sum(quantity*unitprice),2) AS order_value
from retail_final
group by year,invoiceno
)
select 
      year,
      round(avg(order_value),2) AS Avg_ord_value
from avg_value
group by year
order by Avg_ord_value desc ;

-- Which year had the highest quantity of products sold?

select 
       year(invoicedate) AS Year,
       round(sum(quantity),2) AS Highest_quantity_sold
from retail_final
group by year
order by Highest_quantity_sold desc 
limit 1 ;

-- Which year had the highest number of unique orders?
select 
      year(invoicedate) AS Year,
      count(distinct invoiceno) AS Unique_orders
from retail_final
group by year
order by unique_orders desc 
limit 1;

-- Which month had the highest number of unique customers in 2011?
select
      year(invoicedate) AS year,
      month(invoicedate) AS Month,
      count(distinct customerid) as Unique_customers
from retail_final
where year(invoicedate) = 2011
group by year,month
order by unique_customers desc 
limit 10;

-- Which month had the highest total quantity of products sold in 2011?
select 
      year(invoicedate) AS Year,
      month(invoicedate) AS month,
      round(sum(quantity),2) AS Total_quantity
from retail_final
where year(invoicedate) = 2011
group by year,month
order by Total_quantity desc ;

-- Which month had the highest average order value in 2011?

with order_value as 
(
   select
	  year(invoicedate) AS year,
      month(invoicedate) AS month,
      invoiceno,
      round(sum(quantity*unitprice),2) AS Total_order_value
from retail_final
group by year,month,invoiceno
)
select 
        year,
        month,
		round(avg(total_order_value),2) AS Avg_ord_value
from order_value
group by year,month
order by Avg_ord_value desc 
limit 1;

-- Which customers made only one purchase?
select 
      customerid,
      count(distinct invoiceno) AS Customer_purchased
from retail_final
group by customerid
having count(distinct invoiceno) = 1 ;
   
-- What percentage of customers made only one purchase?
with customer_orders as 
(
select 
       customerid,
	count(distinct invoiceno) AS Order_count
from retail_final
group by Customerid
)
 select 
    concat(
       round(
       sum(case when order_count = 1 then 1 else 0 end)
       /count(*)*100,
2),'%') AS  One_Time_Customer_Percentage
from customer_orders;

-- What percentage of customers were repeat customers?
with customer_percentage AS 
(
 select 
        customerid,
        count(distinct invoiceno) AS Order_count
from retail_final
group by customerid
)
 select 
       concat(
	   round(sum(case when order_count >1 then 1 else 0 end)/
       count(*)*100,
       2),
       '%')AS Repeat_customers
from customer_percentage;

-- Which country has the highest revenue per customer?

select 
      country,
      count(distinct customerid) AS Unique_customers,
	  round(sum(quantity*unitprice)/count(distinct customerid),2)AS revenue_per_customers 
from retail_final
group by country
order by revenue_per_customers desc 
limit 10;


-- Which products contribute the highest percentage of total revenue?
select 
      stockcode,
      description,
	  round(sum(quantity*unitprice),2) AS Total_revenue,
	  round(sum(quantity*unitprice)/
      (select sum(quantity*unitprice) from retail_final)*100,2)
       AS Revenue_percentage
from retail_final
group by stockcode,description 
order by Revenue_percentage desc 
limit 20;

-- Which products were purchased by the highest number of unique customers?
select 
      stockcode,
      description,
      count(distinct customerid) AS Unique_customers
from retail_final
group by Stockcode,description
order by Unique_customers desc 
limit 20 ;

-- Which products were purchased only once across the entire dataset?
select 
       stockcode,
       description,
	   count(distinct invoiceno) AS purchased_once
from retail_final
group by Stockcode,description
having count(distinct invoiceno) = 1;

-- Which products have never been purchased by more than one customer?
select 
       stockcode,
       description,
      count(distinct customerid) AS unique_customers
from retail_final
group by stockcode,description 
having count(distinct customerid) = 1 
limit 20;

-- Which customers generated the highest revenue per order?
select
      customerid,

      round(sum(quantity*unitprice)/count(distinct invoiceno),2)AS Highest_revenue_order
from retail_final
group by Customerid
order by Highest_revenue_order desc ;

-- Which customers have the highest total number of items purchased per order?
select 
      customerid,
      round(sum(quantity)/count(distinct invoiceno),2) AS Total_no_of_orders
from retail_final
group by Customerid
order by Total_no_of_orders desc 
limit 20;

-- Which products have the highest average selling price?
select 
       stockcode,
       description,
       round(avg(unitprice),2)AS Avg_selling_price
from retail_final
group by Stockcode,description 
order by Avg_selling_price desc ;

-- Which products have the highest total revenue but also at least 100 unique customers?
select 
      stockcode,
      count(distinct customerid) AS Unique_customerid,
      round(sum(quantity*unitprice),2)AS highest_Total_revenue
from retail_final
group by Stockcode
having count(distinct customerid) >= 100
limit 20 ;

-- Which products have high revenue and high customer reach?
select 
	stockcode,
   count(distinct customerid) AS unique_customers,
   round(sum(quantity*unitprice),2) AS Total_Revenue,
   round(sum(quantity*unitprice)/count(distinct customerid),2) AS revenue_per_customer
from retail_final
group by Stockcode
having count(distinct customerid) >= 100
order by total_revenue desc 
limit 20 ;

-- Which customers generated more than 10,000 in total revenue?
select 
	   customerid,
       round(sum(quantity*unitprice),2) AS Total_revenue
from retail_final
group by Customerid
having sum(quantity*unitprice) > 10000 ;

-- Which customers placed more than 10 orders?
select 
      customerid,
      count(distinct invoiceno) AS Customer_orders
from retail_final
group by Customerid
having count(distinct invoiceno) > 10;

-- Which products generated more than 50,000 in total revenue?
select 
       stockcode,
       round(sum(quantity*unitprice),2) AS Total_revenue
from retail_final
group by Stockcode
having sum(quantity*unitprice) > 50000;

-- Which products were purchased in more than 500 different orders?

select 
      stockcode,
      count(distinct invoiceno) AS Purchased_product
from retail_final
group by Stockcode
having count(distinct invoiceno) > 500;

-- Which customers placed more than 20 orders?
select 
      customerid,
      count(distinct invoiceno) AS Customer_orders
from retail_final
group by Customerid
having count(distinct invoiceno) > 20;

-- Which products had more than 1,000 units sold in total?
select 
      stockcode,
      sum(quantity) AS Products_sold
from retail_final
group by Stockcode
having sum(quantity) > 1000
limit 20;

-- Which countries generated more than 100,000 in total revenue?
select 
      country,
      round(sum(quantity*unitprice),2) AS Total_revenue
from retail_final
group by Country
having sum(quantity*unitprice) > 100000
limit 20;

-- Which countries had more than 100 unique customers?
select 
      country,
      count(distinct customerid) AS Unique_customers
from retail_final
group by Country
having count(distinct customerid) > 100;

-- Which countries had more than 100 unique orders?
select 
	  country,
      count(distinct invoiceno) AS Unique_orders
from retail_final
group by country
having count(distinct invoiceno) > 100;

-- Which products had an average quantity per order greater than 50 units?
select 
      stockcode,
     round(avg(quantity),2) AS Avg_quantity
from retail_final
group by Stockcode
having avg(quantity) > 50 
limit 20;

-- Which customers had an average order value greater than 1,000?
with customer_order as 
(
select 
      customerid,
      invoiceno,
      round(sum(quantity*unitprice),2)AS Total_orders
from retail_final
group by Customerid,invoiceno
)
 select 
        customerid,
        round(avg(total_orders),2)  AS Avg_order_value
from Customer_order
group by Customerid
having avg(total_orders) > 1000;

-- Which customers purchased more than 10,000 total items?
select 
       customerid,
       round(sum(quantity),2) AS Total_items
from retail_final
group by customerid
having sum(quantity) > 10000;

-- Which products had an average selling price below 5?
select 
       stockcode,
       round(avg(unitprice),2) AS Avg_selling_price
from retail_final
group by Stockcode
having avg(unitprice) < 5 
order by Avg_selling_price desc
limit 20;

-- Which customers had a total revenue between 5,000 and 10,000?
select 
       customerid,
       round(sum(quantity*unitprice),2) AS Total_revenue
from retail_final
group by Customerid
having sum(quantity*unitprice) between 5000 and 10000
order by Total_revenue desc 
limit 20 ;

-- Which products had a total quantity sold between 500 and 1,000 units?
select 
      stockcode,
      round(sum(quantity),2) AS Total_quantity
from retail_final
group by Stockcode
having sum(quantity) between 500 and 1000
order by Total_quantity desc 
limit 20;

-- Which customers had a total revenue between 10,000 and 20,000?
select 
       customerid,
       round(sum(quantity*unitprice),2) AS Total_revenue
from retail_final
group by Customerid
having sum(quantity*unitprice) between 10000 and 20000
order by Total_revenue desc 
limit 20 ;

-- What percentage of total revenue came from the top 10 products?

with Total_products AS 
(
  select 
       stockcode,
	   description,
       round(sum(quantity*unitprice),2) AS Total_revenue
from retail_final
where quantity > 0
group by Stockcode,description 
)
select 
       concat(
              round(sum(total_revenue)/
              (select sum(total_revenue) from Total_products)*100,2
), 
'%') AS Top_percentage
from
(
     select Total_revenue
from total_products
order by Total_revenue desc 
limit 10
) AS Top10;

-- What percentage of total revenue came from the United Kingdom?
select country,
	  concat(
             round
                 (
                  sum(quantity*unitprice)/
                  (select sum(quantity*unitprice) 
from retail_final)*100,
2),'%') AS Uk_percentage
from retail_final
where country = 'united kingdom'
and quantity > 0 
group by Country ;

/* What percentage of customers were repeat customers, 
and how much revenue did repeat customers generate
compared with one-time customers? */
 with 
      customer_data 
AS (
    select 
         customerid,
         count(distinct invoiceno) AS orders,
         round(sum(quantity*unitprice),2) AS Revenue
from retail_final
where quantity > 0
group by customerid
),
customer_type as
(
  select
         customerid,
         revenue,
      case 
           when orders > 1 then 'repeat'
           else 'onetime '
           end AS Customer_type
from customer_data
)
 select
       customer_type,
	   count(*) AS Customers,
       concat(round(count(*)*100/(select count(*) from customer_type),2),'%')
AS   Customer_percentage,
	 round(sum(revenue),2) AS Total_revenue
from customer_type
group by Customer_type;
 
 -- What was the monthly revenue trend across 2011?
 select 
        year(invoicedate) AS Year,
        month(invoicedate) AS month,
        round(sum(quantity*unitprice),2) AS Revenue_trend 
from retail_final
where year(invoicedate) = '2011'
group by year,month
order by Revenue_trend desc ;

-- Which month had the strongest and weakest revenue performance in 2011?
 
with performance_revenue AS 
(
  select 
        month(invoicedate) AS month,
        round(sum(quantity*unitprice),2) AS monthly_Revenue
from retail_final
where year(invoicedate) = '2011'
group by month
)
(select
       month,
       monthly_revenue As revenue,
       'strongest' AS Performance  
from performance_revenue  
order by monthly_revenue desc 
limit 1
)
UNION ALL
(
select
       month,
       monthly_revenue As revenue,
       'weakest' AS Performance  
from performance_revenue  
order by monthly_revenue asc 
limit 1 
);

-- Which products had high customer reach but relatively low revenue per customer?

 with revenue AS 
 (
   select 
          stockcode,
          count(distinct customerid) AS Customers,
          sum(quantity*unitprice) AS products
from retail_final
group by stockcode
)
 select 
         stockcode,customers,
         round(products,2)  AS Total_revenue,
         round(products/customers,2) AS Revenue_per_customer
from revenue
order by customers desc , revenue_per_customer asc 
limit 20;

-- Which products had high revenue per customer but relatively low customer reach?
with low_customer as 
(
 select 
        stockcode,
        count(distinct customerid) AS Customers ,
        sum(quantity*unitprice) AS products 
from retail_final
group by stockcode 
)
 select
       stockcode,customers,
       round(products,2) AS Total_revenue,
       round(products/customers) AS revenue_per_customer
from low_customer
order by customers asc ,revenue_per_customer desc 
limit 5 ;

-- Which customers generated the highest lifetime revenue?
select 
      customerid,
      round(sum(quantity*unitprice),2) AS lifetime_revenue
from retail_final
group by customerid
order by lifetime_revenue desc 
limit 5;

-- What percentage of total revenue was generated by the top 10 customers?

with revenue AS 
(
   select 
          customerid,
          round(sum(quantity*unitprice),2)AS Total_revenue
from retail_final
where quantity > 0
group by Customerid
order by total_revenue desc 
limit 10
)
select
	      concat(round(sum(total_revenue)/
	      (select sum(quantity*unitprice)from retail_final
		  where quantity > 0)*100,2),'%')
AS percentage_total
from revenue;











