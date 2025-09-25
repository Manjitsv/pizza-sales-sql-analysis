 -- 1. Retrieve the total number of orders placed.

SELECT 
    COUNT(*) AS total_orders
FROM
    orders;
    

-- 2. Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id;
    
    
-- 3. Identify the highest-priced pizza.

SELECT 
    pt.name, p.price
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
ORDER BY p.price DESC
LIMIT 1;


-- 4. Identify the most common pizza size ordered.

SELECT 
    p.size, SUM(od.quantity) AS total_quantity
FROM
    pizzas p
        JOIN
    order_details od ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY total_quantity DESC
LIMIT 1;



-- 5 List the top 5 most ordered pizza types along with their quantities.

SELECT 
    pizza_types.name,
    SUM(order_details.quantity) AS total_order_quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY name
ORDER BY total_order_quantity desc
LIMIT 5;


-- 6. Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pt.category, SUM(od.quantity) AS total_quantity
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details od ON od.pizza_id = p.pizza_id
GROUP BY pt.category;


-- 7. Determine the distribution of orders by hour of the day.

SELECT 
    HOUR(TIME) AS hour, COUNT(Order_id) AS order_count
FROM
    orders GROUP BY hour;
    
    
-- 8. Join relevant tables to find the category-wise distribution of pizzas.

SELECT 
    category, COUNT(name) AS pizza_count
FROM
    pizza_types
GROUP BY category;



-- 9. calculate the average number of pizzas ordered per day.

SELECT 
    ROUND(AVG(total_quantity), 0) AS avg_daily_orders
FROM
    (SELECT 
        o.date, SUM(od.quantity) AS total_quantity
    FROM
        orders o
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY o.date) AS daily_order_quantity;


-- 10. Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    pt.name,
    SUM(p.price * od.quantity) AS total_revenue
FROM
    pizzas p
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
        JOIN
    pizza_types pt ON pt.pizza_type_id = p.pizza_type_id
GROUP BY pt.name
ORDER BY total_revenue DESC
LIMIT 3;


-- 11. Calculate the percentage contribution of each pizza type to total revenue.

WITH total_revenue_cte AS (
    SELECT SUM(od.quantity * p.price) AS total_revenue FROM order_details od JOIN pizzas p
    ON p.pizza_id = od.pizza_id)
SELECT 
    pt.category,
    ROUND(SUM(od.quantity * p.price) / (SELECT 
                    total_revenue
                FROM
                    total_revenue_cte) * 100,
            2) AS revenue_share
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details od ON od.pizza_id = p.pizza_id
GROUP BY pt.category;


-- 12. Analyze the cumulative revenue generated over time.

SELECT 
    date AS order_date,
    SUM(daily_revenue) OVER (ORDER BY date) AS cumulative_revenue
FROM (
    SELECT 
        o.date,
        SUM(od.quantity * p.price) AS daily_revenue
    FROM order_details od
    JOIN pizzas p 
        ON od.pizza_id = p.pizza_id
    JOIN orders o 
        ON o.order_id = od.order_id
    GROUP BY o.date
) AS daily_total;


-- 13. Determine the top 3 most ordered pizza types based on revenue for each pizza category.

SELECT 
    name, 
    revenue
FROM (
    SELECT 
        category,
        name,
        revenue,
        RANK() OVER (PARTITION BY category ORDER BY revenue DESC) AS ranking
    FROM (
        SELECT 
            pt.category,
            pt.name,
            SUM(od.quantity * p.price) AS revenue
        FROM pizza_types pt
        JOIN pizzas p 
            ON pt.pizza_type_id = p.pizza_type_id
        JOIN order_details od 
            ON od.pizza_id = p.pizza_id
        GROUP BY pt.category, pt.name
    ) AS total_revenue
) AS ranked_revenue
WHERE ranking <= 3;
