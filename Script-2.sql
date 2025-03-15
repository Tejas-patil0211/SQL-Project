use SQL_Project_1 ;

select * from finance LIMIT 5;

SELECT * FROM  finance
WHERE CAST(sale_date AS DATE) 
BETWEEN '2022-01-01' AND '2022-01-31';

select count(*) from finance ;

SELECT category, SUM(total_sale) AS total_revenue 
FROM finance
GROUP BY category;

-- 2 ] Data Exploration & Cleaning

-- 1) Record Count: Determine the total number of records in the dataset.
-- 2) Customer Count: Find out how many unique customers are in the dataset.
-- 3) Category Count: Identify all unique product categories in the dataset.
-- 4) Null Value Check: Check for any null values in the dataset and delete records with missing data.

select count(distinct customer_id)from finance;

SELECT DISTINCT category FROM finance

SELECT * FROM finance WHERE 
sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
gender IS NULL OR age IS NULL OR category IS NULL OR 
quantiy IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM finance
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantiy IS NULL OR price_per_unit IS NULL OR cogs IS NULL;


select * from finance where sale_date='2022-11-05';

 -- 3) Data Analysis & Findings

-- The following SQL queries were developed to answer specific business questions:

-- 1) Write a SQL query to retrieve all columns for sales made on '2022-11-05:

select * from finance where sale_date = '2022-11-05';

-- 2)  Write a SQL query to retrieve all transactions where the category is 'Clothing' and
-- the quantity sold is more than 4 in the month of Nov-2022:'''

select  * from finance  where category="Clothing" and quantiy >=4 and  DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';

-- 3) Write a SQL query to calculate the total sales (total_sale) for each category.:

SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM finance
GROUP BY 1;

-- 4 ) Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

select avg(age) from finance where category="Beauty";

-- 5)Write a SQL query to find all transactions where the total_sale is greater than 1000.:

select * from finance where total_sale >=1000;

-- 6)Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM finance
GROUP 
    BY 
    category,
    gender
ORDER BY 1 ; 

-- 7) Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

WITH MonthlySales AS (
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS `rank`
    FROM finance
    GROUP BY year, month
)
SELECT year, month, avg_sale
FROM MonthlySales
WHERE `rank` = 1;






