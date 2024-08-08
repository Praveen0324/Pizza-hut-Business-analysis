/*Basic:
Q1. Retrieve the total number of orders placed.*/
select count(order_id) as total_order
from orders

-- Q2. Calculate the total revenue generated from pizza sales.

select Round(sum(quantity * price), 1) as total_revenue
from orders_details
join pizzas on 
orders_details.pizza_id = pizzas.pizza_id ;

 -- Q3. Identify the highest-priced pizza.
 select name , price 
 from pizza_types
 join pizzas on 
 pizza_types.pizza_type_id = pizzas.pizza_type_id
 order by price desc
 limit 1;
 
 -- Q4 Identify the most common pizza size ordered.
SELECT 
    size, COUNT(order_details_id) AS most_number
FROM
    pizzas
        JOIN
    orders_details ON pizzas.pizza_id = orders_details.pizza_id
GROUP BY size
ORDER BY most_number DESC
 
 -- Q5 List the top 5 most ordered pizza types along with their quantities.
 
SELECT 
    pizza_types.name, SUM(orders_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5;
 
 
 /*Intermediate:
Q1.Join the necessary tables to find the total quantity of each pizza category ordered.*/

SELECT 
    pizza_types.name,
    category,
    SUM(orders_details.quantity) AS total
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY category
ORDER BY total DESC;

-- Q2. Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(order_time) AS hours, COUNT(order_id) AS total_order
FROM
    orders
GROUP BY hours

-- Q3. Join relevant tables to find the category-wise distribution of pizzas.
SELECT 
    category, COUNT(name)
FROM
    pizza_types
GROUP BY category;

-- Q4. Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT 
    ROUND(AVG(quantity), 0) AS no_of_pizza_order_per_day
FROM
    (SELECT 
        orders.order_date, SUM(orders_details.quantity) AS quantity
    FROM
        orders
    JOIN orders_details ON orders.order_id = orders_details.order_id
    GROUP BY order_date) AS order_quantity
    
-- Q5 . Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    name, SUM(quantity * price) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    orders_details ON pizzas.pizza_id = orders_details.pizza_id
GROUP BY name
ORDER BY revenue DESC
LIMIT 3
