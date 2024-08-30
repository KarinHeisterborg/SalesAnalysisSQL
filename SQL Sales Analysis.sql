select TOP 10 *
FROM dbo.['SQL - Sales Analysis] 

--Number of rows:

SELECT 
   COUNT(*)
FROM ['SQL - Sales Analysis] 

--Looking for Nulls

Select * 
From ['SQL - Sales Analysis] 
Where 
transactions_id IS NULL
OR
sale_date IS NULL
OR
sale_time IS NULL
OR
customer_id IS NULL
OR
gender IS NULL
OR
age IS NULL
OR
category IS NULL
OR
quantiy IS NULL
OR
price_per_unit IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL;


DELETE 
From ['SQL - Sales Analysis] 
    Where 
transactions_id IS NULL
OR
sale_date IS NULL
OR
sale_time IS NULL
OR
customer_id IS NULL
OR
gender IS NULL
OR
age IS NULL
OR
category IS NULL
OR
quantiy IS NULL
OR
price_per_unit IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL;

--DATA EXPLORATION

--Number of Sales

Select Count (*) as total_sale 
From ['SQL - Sales Analysis] 

--Number of Unique Costumers

Select Count (DISTINCT customer_id) as NumCust
From ['SQL - Sales Analysis] 

 --Number of Categories

Select DISTINCT (category) as Categories 
From ['SQL - Sales Analysis]


--Data Analysis & Findings

-- Retrieve all columns for sales made on '2022-11-05

Select * 

From ['SQL - Sales Analysis]
Where sale_date = '2022-11-05';

--Retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

Select *
From ['SQL - Sales Analysis]
Where category = 'Clothing'

 AND   FORMAT(sale_date, 'yyyy-MM') = '2022-11'
 AND   quantiy >= 4;
 
 
 --Calculate the total sales for each category.

Select category,
     SUM (total_sale) as CategSales,
     COUNT (*) as TotalOrders
From ['SQL - Sales Analysis]
Group by category'Clothing'

--Find the average age of customers who purchased items from the 'Beauty' category.:

Select 
     ROUND(AVG(age), 2) as AvgAge
From ['SQL - Sales Analysis]
where (category) = 'Beauty'

 --Find all transactions where the total_sale is greater than 1000.

 SELECT * 
 FROM ['SQL - Sales Analysis]
 WHERE total_sale > 1000
 
 Select transactions_id as Transactions
 From ['SQL - Sales Analysis]
 where total_sale > 1000

 --Total number of transactions (transaction_id) made by each gender in each category.

 Select category, 
        gender,
        count (transactions_id) as Transactions
 From ['SQL - Sales Analysis]
 Group By  category, gender
 Order by 1;

 --Calculate the average sale for each month. Find out best selling month in each year.

 SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    YEAR (sale_date) as year,
    MONTH (sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY YEAR (sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM ['SQL - Sales Analysis]
GROUP BY YEAR(sale_date), 
        MONTH(sale_date)
) as t1
WHERE rank = 1

--Find the top 5 customers based on the highest total sales.

Select TOP 5
       customer_id, 
       Sum (total_sale) as totalSales
FROM ['SQL - Sales Analysis]
Group by customer_id
Order by totalSales Desc


--Find the number of unique customers who purchased items from each category.

Select category,
       Count(DISTINCT customer_id) as UniqCostId
From ['SQL - Sales Analysis]
group by category 


--Create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17).

WITH hourly_sale as
(
SELECT *,
    CASE
    WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
    WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
END AS shift
FROM ['SQL - Sales Analysis]
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift;