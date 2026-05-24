/* =========================================
   SALES ANALYSIS PROJECT (SQL)
   Author: Satnam Singh
   Purpose: Data Analytics Practice Project
========================================= */


/* =========================
   1. CREATE DATABASE
========================= */

DROP DATABASE IF EXISTS sales_project;
CREATE DATABASE sales_project;
USE sales_project;


/* =========================
   2. CREATE TABLES
========================= */

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


/* =========================
   3. INSERT DATA
========================= */

INSERT INTO customers VALUES
(1,'Aman Sharma','Delhi'),
(2,'Rahul Verma','Mumbai'),
(3,'Simran Kaur','Chandigarh'),
(4,'Neha Singh','Pune'),
(5,'Vikram Malhotra','Bangalore'),
(6,'Priya Mehta','Hyderabad'),
(7,'Arjun Patel','Ahmedabad'),
(8,'Sneha Kapoor','Jaipur'),
(9,'Rohan Gupta','Kolkata'),
(10,'Karan Joshi','Lucknow');

INSERT INTO products VALUES
(101,'iPhone 15','Electronics',79999),
(102,'Samsung Galaxy S24','Electronics',74999),
(103,'Dell Laptop','Computers',65000),
(104,'HP Laptop','Computers',62000),
(105,'Boat Headphones','Accessories',2999),
(106,'Apple Watch','Wearables',45999),
(107,'Nike Shoes','Fashion',5999),
(108,'Adidas T-Shirt','Fashion',1999),
(109,'Office Chair','Furniture',8999),
(110,'Study Table','Furniture',11999);

INSERT INTO orders VALUES
(1001,1,'2026-01-10',79999),
(1002,2,'2026-01-15',65000),
(1003,3,'2026-02-05',2999),
(1004,4,'2026-02-20',45999),
(1005,5,'2026-03-01',5999),
(1006,1,'2026-03-12',11999),
(1007,6,'2026-03-18',74999),
(1008,7,'2026-04-02',62000),
(1009,8,'2026-04-10',1999),
(1010,9,'2026-04-15',8999),
(1011,10,'2026-05-01',79999),
(1012,2,'2026-05-05',45999),
(1013,3,'2026-05-11',5999),
(1014,4,'2026-05-20',65000),
(1015,5,'2026-06-01',2999);

INSERT INTO order_items VALUES
(1,1001,101,1),
(2,1002,103,1),
(3,1003,105,1),
(4,1004,106,1),
(5,1005,107,1),
(6,1006,110,1),
(7,1007,102,1),
(8,1008,104,1),
(9,1009,108,1),
(10,1010,109,1),
(11,1011,101,1),
(12,1012,106,1),
(13,1013,107,1),
(14,1014,103,1),
(15,1015,105,1);


/* =========================
   4. ANALYTICS QUERIES
========================= */


/* 1. Total spending per customer */
SELECT c.customer_name,
       SUM(o.amount) AS total_spending
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;


/* 2. Top 3 highest spending customers */
SELECT c.customer_name,
       SUM(o.amount) AS total_spending
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spending DESC
LIMIT 3;


/* 3. Monthly revenue analysis */
SELECT MONTH(order_date) AS month,
       SUM(amount) AS revenue
FROM orders
GROUP BY MONTH(order_date);


/* 4. Product performance (best selling products) */
SELECT p.product_name,
       SUM(o.quantity) AS total_sold
FROM products p
JOIN order_items o
ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sold DESC;


/* 5. Category-wise revenue analysis */
SELECT p.category,
       SUM(p.price * o.quantity) AS revenue
FROM products p
JOIN order_items o
ON p.product_id = o.product_id
GROUP BY p.category;


-- =========================
-- 5. ADVANCED ANALYTICS QUERIES
-- =========================


/* Identify repeat customers */

SELECT c.customer_name,
       COUNT(o.order_id) AS total_orders,
       CASE 
           WHEN COUNT(o.order_id) > 1 THEN 'Repeat Customer'
           ELSE 'One-Time Customer'
       END AS customer_type
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;


/* Monthly revenue growth analysis */

WITH monthly_sales AS (
    SELECT MONTH(order_date) AS month,
           SUM(amount) AS revenue
    FROM orders
    GROUP BY MONTH(order_date)
)

SELECT month,
       revenue,
       LAG(revenue) OVER (ORDER BY month) AS prev_month,
       ROUND(
           (revenue - LAG(revenue) OVER (ORDER BY month))
           / LAG(revenue) OVER (ORDER BY month) * 100,
           2
       ) AS growth_percent
FROM monthly_sales;


/* Best product in each category */

WITH ranked_products AS (
    SELECT p.category,
           p.product_name,
           SUM(o.quantity) AS total_sold,
           RANK() OVER (PARTITION BY p.category ORDER BY SUM(o.quantity) DESC) AS rnk
    FROM products p
    JOIN order_items o
    ON p.product_id = o.product_id
    GROUP BY p.category, p.product_name
)

SELECT category, product_name, total_sold
FROM ranked_products
WHERE rnk = 1;


/* Running total of revenue over time */

SELECT order_date,
       amount,
       SUM(amount) OVER (ORDER BY order_date) AS running_total
FROM orders;


/* Customer ranking by spending */

WITH customer_spending AS (
    SELECT c.customer_name,
           SUM(o.amount) AS total_spent
    FROM customers c
    JOIN orders o
    ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.customer_name
)

SELECT customer_name,
       total_spent,
       DENSE_RANK() OVER (ORDER BY total_spent DESC) AS rnk
FROM customer_spending;

