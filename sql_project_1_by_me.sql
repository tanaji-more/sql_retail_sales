-- SQL retail sales analaysis - P1
CREATE DATABASE sql_project_p1;

--- create table
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales(
			transactions_id	INT PRIMARY KEY,
			sale_date DATE,
			sale_time TIME,
			customer_id INT,
			gender VARCHAR(20),
			age INT,
			category VARCHAR(20),
			quantiy INT,
			price_per_unit FLOAT,
			cogs FLOAT,
			total_sale FLOAT

)

SELECT * FROM retail_sales
limit 10;

select count(*) from retail_sales;

--- Data Cleaning


delete from retail_sales 
where
select * from retail_sales
where

	transactions_id IS NULL
	or
	sale_date IS NULL
	or 
	sale_time IS NULL
	or 
	gender IS NULL
	or 
	age is null
	or 
	category is null 
	or 
	quantiy is null
	or
	price_per_unit is null
	or
	cogs is null
	or
	total_Sale is null;


delete from retail_sales 
where
	transactions_id IS NULL
	or
	sale_date IS NULL
	or 
	sale_time IS NULL
	or 
	gender IS NULL
	or 
	age is null
	or 
	category is null 
	or 
	quantiy is null
	or
	price_per_unit is null
	or
	cogs is null
	or
	total_Sale is null;


--- how many total sales

select count(DISTINCT(customer_id)) as total_sales from retail_sales

select * from retail_sales


select distinct category from retail_sales


--- Data analysis 

--- Q1. Write a SQL query to retrieve all columns for sales made on '2022-11-05:

select *
from retail_sales
where sale_date = '2022-11-05'

-- Q2. Write a SQL query to retrieve all transactions where the category is 'Clothing' 
-- and the quantity sold is more than 4 in the month of Nov-2022:

select *
from retail_sales
where category = 'Clothing'
AND to_char(sale_date, 'YYYY-MM') = '2022-11'
AND quantiy >=4

-- Q .3 Write a SQL query to calculate the total sales (total_sale) for each category.:

select 
	category,
	sum(total_sale) as net_sale,
	count(*) as total_orders 
from retail_sales
group by 1

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

select 
	round(avg(age),2) as avg_age

from retail_sales
where category= 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.:


select * 
from retail_sales
where total_sale>1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:


select 
	category,
	gender,
	count(*) as total_trans
from
retail_sales
group by category, gender
order by 1


-- Q7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT * from 
	(
	select 
		extract(YEAR FROM sale_date) as year,
		extract (MONTH FROM sale_date) as month,
		avg(total_sale) as avg_sale,
		RANK () OVER (PARTITION BY EXTRACT (YEAR FROM sale_date) order by AVG (total_sale) DESC) as  rank
	from retail_sales
	group by 1,2
) as t1
where rank = 1 

--- Q.8 **Write a SQL query to find the top 5 customers based on the highest total sales **:

select 
	customer_id,
	sum(total_sale) as total_sale
from retail_sales
group by 1
order by 2 desc
limit 5

--- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.:


select 
	category,
	count( distinct customer_id) as unique_cx
from retail_sales
group by 1


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):


WITH hourly_sales AS
(
	select 
		*,
		case
			when EXTRACT (hour from sale_time) <12 then 'Morning' 
			when EXTRACT (hour from sale_time) BETWEEN 12 AND 17 then 'Afternoon'
			else 'Evening'
		end as shift
	from retail_sales
)

select 

	shift,
	count(*) as total_orders
from hourly_sales
group by shift



select extract( hour from current_time)