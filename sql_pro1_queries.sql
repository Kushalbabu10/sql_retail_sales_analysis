-- checking total records
SELECT 
    *
FROM
    sql_pro1;
    
SELECT 
    COUNT(*)
FROM
    sql_pro1;


-- checking for null values
-- transactions_id
SELECT 
    *
FROM
    sql_pro1
WHERE
    transactions_id = 1432;

-- sale_date
SELECT 
    *
FROM
    sql_pro1
WHERE
    quantiy IS NULL;

-- instead of checking indivisual columns check overall in once
SELECT 
    *
FROM
    sql_pro1
WHERE
    transactions_id IS NULL
        OR sale_date IS NULL
        OR sale_time IS NULL
        OR gender IS NULL
        OR category IS NULL
        OR quantiy IS NULL
        OR cogs IS NULL
        OR total_sale IS NULL
;

-- data exploration analysis
-- 1.How many sales do we have?
SELECT 
    COUNT(*) AS total_sales
FROM
    sql_pro1;

-- 2.How many unique customer do we have?
SELECT 
    COUNT(DISTINCT customer_id) AS total_customers
FROM
    sql_pro1;

-- 3.How many category and what are the category do we have?
SELECT DISTINCT
    category AS names_category,
    COUNT(category) AS total_category
FROM
    sql_pro1
GROUP BY category;


-- Data Analysis and Business problems and solutions
-- 1.write a sql query to retrieve all columns for sales made on '2022-11-05'?
SELECT 
    *
FROM
    sql_pro1
WHERE
    sale_date = '2022-11-05';
    
-- 2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in 
-- the month of Nov-2022
SELECT 
    *
FROM
    sql_pro1
WHERE
    category = 'clothing'
        AND sale_date LIKE '2022-11%'
        AND quantiy >= 4
ORDER BY sale_date
;

-- 3.Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
    category, SUM(total_sale) AS net_sale, count(*) as total_orders
FROM
    sql_pro1
GROUP BY category
;

-- 4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT 
    AVG(age) avg_age
FROM
    sql_pro1
WHERE
    category = 'beauty'
;

-- 5.Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT 
    *
FROM
    sql_pro1
WHERE
    total_sale > 1000;


-- 6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT 
     category, gender, COUNT(*) as total_transactions
FROM
    sql_pro1
GROUP BY  category,gender
ORDER BY category;


-- 7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select `year`, months, avg_sales
from 
(
	SELECT 
		YEAR(sale_date) AS `year`,
		MONTHNAME(sale_date) AS months,
		round(AVG(total_sale),2) avg_sales,
		rank() over(partition by YEAR(sale_date) order by round(AVG(total_sale),2) desc) as ranks
	FROM
		sql_pro1
	GROUP BY `year`, months
	ORDER BY `year`, avg_sales desc
)as t2
where ranks = 1
;


-- 8.Write a SQL query to find the top 5 customers based on the highest total sales
SELECT 
     customer_id ,sum(total_sale) as sum_total_sales
FROM
    sql_pro1
group by customer_id
order by sum_total_sales desc
limit 5
;


-- 9.Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
    COUNT(DISTINCT customer_id) as count_of_customers, category
FROM
    sql_pro1
GROUP BY category
ORDER BY category;

-- 10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
SELECT 
    *
    CASE
        WHEN HOUR(sale_time) < 12 THEN 'morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'afternoon'
        WHEN HOUR(sale_time) > 17 THEN 'evening'
    END AS shifts,
    quantiy
FROM
    sql_pro1
ORDER BY sale_time
;