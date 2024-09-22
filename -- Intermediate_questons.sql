--  INTERMEDIATE QUESTIONS  

-- Group the orders by date and calculate 
-- the average number of pizzas ordered per day.

SELECT 
    ROUND(AVG(quantity), 0) AS avg_quantity
FROM
    (SELECT 
        o.order_date, SUM(od.quantity) AS quantity
    FROM
        orders o
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY o.order_date) AS order_quantity;
    


-- Join the necessary tables to find the total 
-- quantity of each pizza category ordered.

SELECT 
    pt.category, FORMAT(SUM(od.quantity),0) AS total_quantity
FROM
    pizza_types pt
JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
JOIN
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY pt.category
ORDER BY total_quantity DESC;




-- Determine the distribution of orders by hour of the day. 

SELECT 
    HOUR(order_time) AS Hour, 
    COUNT(order_id) AS Order_count
FROM
    orders
GROUP BY HOUR(order_time);



-- Determine the top 3 most ordered pizza types based on revenue.

select 
    pt.name,
    CONCAT('$ ', Format(sum(od.quantity * p.price), 1)) as revenue
from 
    pizza_types pt 
join 
    pizzas p on p.pizza_type_id = pt.pizza_type_id
join 
    order_details od on od.pizza_id = p.pizza_id
group by pt.name
order by revenue desc
limit 3;






