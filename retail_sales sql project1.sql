create database retail_project;
CREATE TABLE retail_sales
(
   transactions_id int PRIMARY KEY,	
   sale_date date,	
   sale_time time,	
   customer_id int,
   gender varchar(15),
   age int,	
   category varchar(15),
   quantity int,	
   price_per_unit float,
   cogs float,
   total_sale float
);

select *from retail_sales
where transactions_id is null;

select *from retail_sales
where sale_date is null;

select *from retail_sales
where sale_time is null;

select *from retail_sales
where 
    transactions_id is null
    or
    sale_date is null
    or
    sale_time is null
    or
    customer_id is null
    or
    gender is null
    or
    age is null
    or
    category is null
    or 
    quantity is null
    or
    price_per_unit is null
    or
    cogs is null
    or 
    total_sale is null;
    
    select count(distinct customer_id) as total_sales from retail_sales;
    select count(distinct category) as total_sales from retail_sales;
    select distinct category from retail_sales;
    (--q.1 write a sql query to retrive all columns for sales made on 2022-11-05;)
    select * 
    from retail_sales
    where sale_date='2022-11-05';
    
--q.2 write a sql query to retrive all tractions where the category is clothing and the quantity sold is more than 10 in the month for nov-2022;

SELECT *
FROM retail_sales
WHERE category = 'clothing'
  AND quantity >=2
  AND sale_date >= '2022-11-01'
  AND sale_date < '2022-12-01';
  
 --q3 write a mysql query to calculate the total sales (totle_sales) for each category; 

SELECT
   category,
   SUM(total_sale) AS net_sale,
   count(*) as total_orders
FROM retail_sales
GROUP BY category;

q.4 write a sql query to find the average age of customers who purchased items from the 'beauty' category;

select
    round(avg(age),2)as avg_age
from retail_sales
where category='beauty';

q.5 write a sql query to find all transactions where the total_sale is greater than 1000;

select * from retail_sales
where total_sale > 1000;

q.6 write a sql query to find the total number of tractions (transaction_id) made by each gender in each category;
select
    category,
    gender,
    count(*) as total_tans
from retail_sales
group by
       category,
       gender
order by 1;

q.7 write a sql query to calculate the average sale for each month. find  out best selling month in each year;

SELECT 
    sale_year AS year,
    sale_month AS month,
    avg_sale
FROM
(
    SELECT 
        YEAR(sale_date) AS sale_year,
        MONTH(sale_date) AS sale_month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS sale_rank
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS t1
WHERE sale_rank = 1;

q.8 write a sql query to find the top 5 customers based on the highest total sales;

select  
    customer_id,
    sum(total_sale) as total_sales
from retail_sales
group by 1
order by 2 desc
limit 5;
q.9 write sql query to find number of unique customers who purchased items from each category;

select  
    category,
    count(distinct customer_id) as cnt_unique_cs
from retail_sales
group by category;


q.10 write a sql query to create each shift and number of order (example morning <=12, afternoon between 12 & 17, evening >17;

with hourly_sale
as
(
select *,
	case
      when hour (sale_time)<12 then 'morning'
      when hour( sale_time) between 12 and 17 then 'afternoon'
      else 'evening'
    end as shift  
from retail_sales
)
select
    shift,
    count(*) as total_orders
from hourly_sale
group by shift;

--end of project--;



   