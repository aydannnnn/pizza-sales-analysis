SELECT 
    *
FROM
    data_pizza_sales;

-- 1. Total revenue: 
SELECT 
    SUM(total_price) AS Total_Revenue
FROM
    data_pizza_sales;

-- 2. Average Order Value
SELECT 
    (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_value
FROM
    data_pizza_sales;

-- 3. Total pizza sold
SELECT 
    SUM(quantity) AS Total_pizza_sold
FROM
    data_pizza_sales;

-- 4. Total orders
SELECT 
    COUNT(DISTINCT order_id) AS Total_orders
FROM
    data_pizza_sales;

-- 5. Average pizza order
SELECT 
    CAST(CAST(SUM(quantity) AS DECIMAL (10 , 2 )) / CAST(COUNT(DISTINCT order_id) AS DECIMAL (10 , 2 ))
        AS DECIMAL (10 , 2 )) AS Avg_Pizzas_per_order
FROM
    data_pizza_sales;

-- Order Date
SELECT 
    MIN(order_date) AS tanggal_awal,
    MAX(order_date) AS tanggal_akhir
FROM
    data_pizza_sales;


SELECT 
    pizza_name, NULL AS total_jenis
FROM
    (SELECT DISTINCT
        pizza_name
    FROM
        data_pizza_sales) AS daftar 
UNION ALL SELECT 
    'Total Jenis' AS pizza_name, COUNT(DISTINCT pizza_name)
FROM
    data_pizza_sales;

-- Menu Pizza Paling Banyak Terjual (Salah Satu Size)
SELECT 
    pizza_name, pizza_size, SUM(quantity) AS total_terjual
FROM
    data_pizza_sales
GROUP BY pizza_name , pizza_size
ORDER BY total_terjual DESC
LIMIT 5;

-- Menu Pizza Paling Sedikit Terjual (Salah Satu Size)
SELECT 
    pizza_name, pizza_size, SUM(quantity) AS total_terjual
FROM
    data_pizza_sales
GROUP BY pizza_name , pizza_size
ORDER BY total_terjual ASC
LIMIT 5;

-- Menu Pizza Paling Banyak Terjual (Semua Size)
WITH top_pizza AS (
  SELECT pizza_name
  FROM data_pizza_sales
  GROUP BY pizza_name
  ORDER BY SUM(quantity) DESC
  LIMIT 1
)

SELECT 
    pizza_name, pizza_size, SUM(quantity) AS total_terjual
FROM
    data_pizza_sales
WHERE
    pizza_name = (SELECT 
            pizza_name
        FROM
            top_pizza)
GROUP BY pizza_name , pizza_size
ORDER BY total_terjual DESC;

-- Menu Pizza Paling Sedikit Terjual (Semua Size)
WITH top_pizza AS (
  SELECT pizza_name
  FROM data_pizza_sales
  GROUP BY pizza_name
  ORDER BY SUM(quantity) ASC
  LIMIT 1
)

SELECT 
    pizza_name, pizza_size, SUM(quantity) AS total_terjual
FROM
    data_pizza_sales
WHERE
    pizza_name = (SELECT 
            pizza_name
        FROM
            top_pizza)
GROUP BY pizza_name , pizza_size
ORDER BY total_terjual ASC;

-- Peak Hour Pizza Sold
SELECT 
    EXTRACT(HOUR FROM order_time) AS order_hours,
    SUM(quantity) AS total_pizzas_sold
FROM
    data_pizza_sales
GROUP BY EXTRACT(HOUR FROM order_time)
ORDER BY EXTRACT(HOUR FROM order_time);

-- Weekly trends for orders
SELECT 
    YEAR(STR_TO_DATE(order_date, '%m/%d/%Y')) AS order_year,
    WEEK(STR_TO_DATE(order_date, '%m/%d/%Y')) AS order_week,
    COUNT(DISTINCT order_id) AS total_orders
FROM
    data_pizza_sales
GROUP BY order_year , order_week
ORDER BY order_year , order_week;

-- Penjualan Terbanyak Berdasarkan Kategori --
SELECT 
    pizza_category, SUM(quantity) AS total_terjual
FROM
    data_pizza_sales
GROUP BY pizza_category
ORDER BY total_terjual DESC;

-- % of sales pizza category
SELECT 
    pizza_category,
    CAST(SUM(total_price) AS DECIMAL (10 , 2 )) AS total_revenue,
    CAST(SUM(total_price) * 100 / (SELECT 
                SUM(total_price)
            FROM
                data_pizza_sales)
        AS DECIMAL (10 , 2 )) AS pct
FROM
    data_pizza_sales
GROUP BY pizza_category;

-- % of sales by pizza size
SELECT 
    pizza_size,
    CAST(SUM(total_price) AS DECIMAL (10 , 2 )) AS total_revenue,
    CAST(SUM(total_price) * 100 / (SELECT 
                SUM(total_price)
            FROM
                data_pizza_sales)
        AS DECIMAL (10 , 2 )) AS pct
FROM
    data_pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;

-- Top 5 Pizza by Revenue
SELECT 
    pizza_name, SUM(total_price) AS Total_revenue
FROM
    data_pizza_sales
GROUP BY pizza_name
ORDER BY Total_revenue DESC
LIMIT 5;

-- Bottom 5 Pizza by Revenue
SELECT 
    pizza_name, SUM(total_price) AS Total_revenue
FROM
    data_pizza_sales
GROUP BY pizza_name
ORDER BY Total_revenue ASC
LIMIT 5;

-- Top 5 Pizza by Quantity
SELECT 
    pizza_name, SUM(quantity) AS Total_pizza_sold
FROM
    data_pizza_sales
GROUP BY pizza_name
ORDER BY Total_pizza_sold DESC
LIMIT 5;

-- Bottom 5 Pizza by Quantity
SELECT 
    pizza_name, SUM(quantity) AS Total_pizza_sold
FROM
    data_pizza_sales
GROUP BY pizza_name
ORDER BY Total_pizza_sold ASC
LIMIT 5;

-- Top 5 Pizza by Total orders
SELECT 
    pizza_name, COUNT(DISTINCT order_id) AS Total_orders
FROM
    data_pizza_sales
GROUP BY pizza_name
ORDER BY Total_orders DESC
LIMIT 5;

-- Bottom 5 Pizza by Total orders
SELECT 
    pizza_name, COUNT(DISTINCT order_id) AS Total_orders
FROM
    data_pizza_sales
GROUP BY pizza_name
ORDER BY Total_orders ASC
LIMIT 5;

SELECT 
    pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM
    pizza_sales
WHERE
    pizza_category = 'Classic'
GROUP BY pizza_name
ORDER BY Total_Orders ASC
LIMIT 5;