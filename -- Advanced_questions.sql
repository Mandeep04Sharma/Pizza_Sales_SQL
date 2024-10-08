--  Advanced QUESTIONS 

-- Calculate the percentage contribution of 
-- each pizza type to total revenue.

SELECT 
    pt.category,
    CONCAT(
        ROUND(
            (SUM(od.quantity * p.price) / 
             (SELECT SUM(od_inner.quantity * p_inner.price)
              FROM order_details od_inner
              JOIN pizzas p_inner ON od_inner.pizza_id = p_inner.pizza_id)
            ) * 100, 2
        ), '%'
    ) AS revenue_percentage
FROM 
    pizza_types pt
JOIN 
    pizzas p ON p.pizza_type_id = pt.pizza_type_id
JOIN 
    order_details od ON od.pizza_id = p.pizza_id
GROUP BY 
    pt.category
ORDER BY 
    revenue_percentage DESC;
    


-- Analyze the cumulative revenue generated over time.
  
SELECT 
    order_date,
    CONCAT('$ ', FORMAT(SUM(revenue) OVER (ORDER BY order_date), 2)) AS cum_revenue
FROM (
    SELECT 
        o.order_date,
        SUM(od.quantity * p.price) AS revenue
    FROM 
        order_details od
    JOIN 
        pizzas p ON od.pizza_id = p.pizza_id
    JOIN 
        orders o ON o.order_id = od.order_id
    GROUP BY 
        o.order_date
) AS Sales;



-- Determine the top 3 most ordered pizza types 
-- based on revenue for each pizza category.
    
SELECT name, 
       CONCAT('$ ', FORMAT(revenue, 1)) AS revenue
FROM (
    SELECT pt.category, pt.name, 
           SUM(od.quantity * p.price) AS revenue,
           RANK() OVER (PARTITION BY pt.category ORDER BY SUM(od.quantity * p.price) DESC) AS rn
    FROM pizza_types pt
    JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
    JOIN order_details od ON od.pizza_id = p.pizza_id
    GROUP BY pt.category, pt.name
) AS ranked_pizzas
WHERE rn <= 3;


    
