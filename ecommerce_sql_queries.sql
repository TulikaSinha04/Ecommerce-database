SELECT * FROM customer;

SELECT * FROM sales WHERE YEAR(order_date) = 2023;

SELECT * FROM products ORDER BY price DESC LIMIT 10;

SELECT c.name, SUM(oi.quantity * p.price) AS TotalSales
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.name
ORDER BY TotalSales DESC;

SELECT s.order_id, c.first_name, c.last_name, s.order_date
FROM sales s
INNER JOIN customer c ON s.customer_id = c.customer_id;


SELECT c.first_name, c.last_name, s.order_id
FROM customer c
LEFT JOIN sales s ON c.customer_id = s.customer_id;

SELECT c.first_name, c.last_name, s.order_id
FROM customer c
RIGHT JOIN sales s ON c.customer_id = s.customer_id;

SELECT c.customer_id, c.first_name, SUM(oi.quantity * p.price) AS TotalSpent
FROM customer c
JOIN sales o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.first_name
HAVING TotalSpent > (
    SELECT AVG(total_spent) 
    FROM (
        SELECT SUM(oi2.quantity * p2.price) AS total_spent
        FROM sales o2
        JOIN order_items oi2 ON o2.order_id = oi2.order_id
        JOIN products p2 ON oi2.product_id = p2.product_id
        GROUP BY o2.customer_id
    ) AS avg_sub
);


SELECT AVG(price) AS AvgProductPrice FROM products;

SELECT MAX(oi.quantity * p.price) AS MaxOrderValue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;

SELECT SUM(oi.quantity * p.price) AS TotalRevenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;


SELECT COUNT(DISTINCT customer_id) AS UniqueCustomers FROM sales;

CREATE VIEW MonthlySale AS
SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS Month,
       SUM(oi.quantity * p.price) AS TotalSales
FROM sales o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m');

SELECT * FROM MonthlySale ORDER BY Month;

CREATE INDEX idx_customer ON sales(customer_id);
