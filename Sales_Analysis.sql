-- Pizza Sales SQL Queries
-- KPI 's (KEY PROGRAMMING INDICATOR) Requirements

SELECT * FROM pizza_sales;
-- 1. Total Revenue
SELECT SUM(total_price) AS Total_Revenue 
FROM pizza_sales;

-- 2. Average Order values
SELECT SUM(total_price) / COUNT(DISTINCT order_id) Avg_order_value 
FROM pizza_sales;

-- 3. Total Pizzas Sold
SELECT SUM(quantity) AS Total_pizza_sold
 FROM pizza_sales;

-- 4. Total Order
SELECT COUNT(DISTINCT order_id) AS Total_order 
FROM pizza_sales;

-- 5. Average Pizzas per order
SELECT SUM(quantity) /COUNT(DISTINCT order_id) AS Avg_pizza_per_order 
FROM pizza_sales;

-- Chart Requirements
-- 1. Daily trends for total orders

SELECT 
    DAYNAME(order_dt) AS order_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM (
    SELECT 
        STR_TO_DATE(order_date, '%d-%m-%Y') AS order_dt,
        order_id
    FROM pizza_sales
) t
GROUP BY 
    DAYOFWEEK(order_dt),
    DAYNAME(order_dt)
ORDER BY 
    DAYOFWEEK(order_dt);
    
-- 2. Hourly trends for total orders

SELECT HOUR(order_time) AS Order_hours , COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY Order_hours
ORDER BY Order_hours ;

-- 3. Percentage of Sales by Pizza Category

SELECT  pizza_category, SUM(total_price) AS Total_sales ,
ROUND(
SUM(total_price) * 100 /
(SELECT SUM(total_price) FROM pizza_sales 
WHERE MONTH(STR_TO_DATE(order_date, '%d-%m-%Y')) =1 
) ,
2)AS sales_percentage
FROM pizza_sales 
WHERE MONTH(STR_TO_DATE(order_date, '%d-%m-%Y')) =1 
GROUP BY pizza_category
ORDER BY pizza_category;

SELECT  pizza_category, SUM(total_price) * 100 /  ## This is not a good code for pie chart and also not a good parctice
(SELECT SUM(total_price) FROM pizza_sales ) 
AS sales_percentage
FROM pizza_sales
 GROUP BY pizza_category 
;

-- 4. Percentage of sales per pizza size

SELECT  pizza_size, SUM(total_price) AS Total_sales ,
ROUND(
SUM(total_price) * 100 /
(SELECT SUM(total_price) FROM pizza_sales 
) ,
2)AS sales_percentage
FROM pizza_sales 
GROUP BY pizza_size
ORDER BY sales_percentage;

-- 5. Total pizzas sold by pizza category

SELECT pizza_category , SUM(quantity) AS Total_pizza_sold
FROM pizza_sales
GROUP BY pizza_category ;

-- 6. Top 5 best sellers by Total pizzas sold

SELECT  pizza_name , SUM(quantity) AS Total_pizza_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(quantity) DESC 
LIMIT 5;

-- 7. Bottom 5 Worst Sellers by Total Pizzas Sold 

SELECT  pizza_name , SUM(quantity) AS Total_pizza_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(quantity) ASC
LIMIT 5;