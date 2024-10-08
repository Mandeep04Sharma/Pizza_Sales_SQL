--  BASIC QUESTIONS 

-- Retrieve the total number of orders placed.
SELECT 
    COUNT(order_id)
FROM
    orders;


-- Calculate the total revenue generated from pizza sales.
SELECT 
 ROUND(SUM(order_details.quantity * pizzas.price),2) AS Total_Revenue
FROM
 order_details
JOIN
 pizzas ON order_details.pizza_id = pizzas.pizza_id;
  

-- Identify the highest-priced pizza.
SELECT 
    pt.name, p.price
FROM
    pizza_types pt
join pizzas p on pt.pizza_type_id = p.pizza_type_id
order by p.price desc
limit 1;


-- Identify the most common pizza size ordered.
SELECT 
    p.size, 
    COUNT(od.order_details_id) AS order_count
FROM
    pizzas p
join 
    order_details od on p.pizza_id = od.pizza_id
GROUP BY p.size
ORDER BY order_count DESC;


-- List the top 5 most ordered pizza types 
-- along with their quantities.

SELECT 
    pt.name, 
    SUM(od.quantity) AS quantity
FROM
    pizza_types pt
JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
JOIN 
    order_details od ON od.pizza_id = p.pizza_id
GROUP BY pt.name
ORDER BY quantity DESC
LIMIT 5;



