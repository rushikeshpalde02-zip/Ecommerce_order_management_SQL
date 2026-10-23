-- ============================================================
-- PROJECT 1: E-COMMERCE ORDER MANAGEMENT SYSTEM
-- MySQL Schema + Sample Data + Practice Queries
-- Based on: Brazilian E-Commerce (Olist) dataset structure
-- https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
-- ============================================================

DROP DATABASE IF EXISTS ecommerce_order_management;
CREATE DATABASE ecommerce_order_management;
USE ecommerce_order_management;

-- ============================================================
-- SECTION 1: SCHEMA (TABLES + RELATIONSHIPS)
-- ============================================================

CREATE TABLE customers (
    customer_id   INT AUTO_INCREMENT PRIMARY KEY,
    first_name    VARCHAR(50) NOT NULL,
    last_name     VARCHAR(50) NOT NULL,
    email         VARCHAR(100) UNIQUE NOT NULL,
    phone         VARCHAR(20),
    city          VARCHAR(50),
    state         VARCHAR(50),
    zip_code      VARCHAR(10),
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sellers (
    seller_id     INT AUTO_INCREMENT PRIMARY KEY,
    seller_name   VARCHAR(100) NOT NULL,
    city          VARCHAR(50),
    state         VARCHAR(50)
);

CREATE TABLE product_categories (
    category_id    INT AUTO_INCREMENT PRIMARY KEY,
    category_name  VARCHAR(100) NOT NULL
);

CREATE TABLE products (
    product_id     INT AUTO_INCREMENT PRIMARY KEY,
    product_name   VARCHAR(150) NOT NULL,
    category_id    INT,
    seller_id      INT,
    price          DECIMAL(10,2) NOT NULL,
    weight_g       INT,
    stock_quantity INT DEFAULT 0,
    FOREIGN KEY (category_id) REFERENCES product_categories(category_id),
    FOREIGN KEY (seller_id) REFERENCES sellers(seller_id)
);

CREATE TABLE orders (
    order_id        INT AUTO_INCREMENT PRIMARY KEY,
    customer_id     INT NOT NULL,
    order_date      DATETIME NOT NULL,
    order_status    ENUM('pending','processing','shipped','delivered','cancelled') DEFAULT 'pending',
    delivered_date  DATETIME NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id  INT AUTO_INCREMENT PRIMARY KEY,
    order_id       INT NOT NULL,
    product_id     INT NOT NULL,
    quantity       INT NOT NULL DEFAULT 1,
    unit_price     DECIMAL(10,2) NOT NULL,
    freight_value  DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE payments (
    payment_id      INT AUTO_INCREMENT PRIMARY KEY,
    order_id        INT NOT NULL,
    payment_type    ENUM('credit_card','debit_card','upi','net_banking','cod') NOT NULL,
    installments    INT DEFAULT 1,
    payment_value   DECIMAL(10,2) NOT NULL,
    payment_date    DATETIME NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE reviews (
    review_id       INT AUTO_INCREMENT PRIMARY KEY,
    order_id        INT NOT NULL,
    customer_id     INT NOT NULL,
    review_score    INT CHECK (review_score BETWEEN 1 AND 5),
    review_comment  TEXT,
    review_date     DATETIME NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- ============================================================
-- SECTION 2: SAMPLE DATA
-- ============================================================

INSERT INTO customers (first_name, last_name, email, phone, city, state, zip_code) VALUES
('Ravi', 'Kumar', 'ravi.kumar@example.com', '9876543210', 'Mumbai', 'Maharashtra', '400001'),
('Priya', 'Sharma', 'priya.sharma@example.com', '9876543211', 'Delhi', 'Delhi', '110001'),
('Amit', 'Patel', 'amit.patel@example.com', '9876543212', 'Ahmedabad', 'Gujarat', '380001'),
('Sneha', 'Reddy', 'sneha.reddy@example.com', '9876543213', 'Hyderabad', 'Telangana', '500001'),
('Vikram', 'Singh', 'vikram.singh@example.com', '9876543214', 'Jaipur', 'Rajasthan', '302001'),
('Anjali', 'Nair', 'anjali.nair@example.com', '9876543215', 'Kochi', 'Kerala', '682001'),
('Karan', 'Mehta', 'karan.mehta@example.com', '9876543216', 'Pune', 'Maharashtra', '411001'),
('Divya', 'Iyer', 'divya.iyer@example.com', '9876543217', 'Chennai', 'Tamil Nadu', '600001');

INSERT INTO sellers (seller_name, city, state) VALUES
('TechWorld Store', 'Bengaluru', 'Karnataka'),
('HomeEssentials Co', 'Mumbai', 'Maharashtra'),
('FashionHub', 'Delhi', 'Delhi'),
('GadgetZone', 'Pune', 'Maharashtra'),
('BookNest', 'Chennai', 'Tamil Nadu');

INSERT INTO product_categories (category_name) VALUES
('Electronics'), ('Home & Kitchen'), ('Fashion'), ('Books'), ('Sports');

INSERT INTO products (product_name, category_id, seller_id, price, weight_g, stock_quantity) VALUES
('Wireless Mouse', 1, 1, 599.00, 150, 200),
('Bluetooth Headphones', 1, 4, 1999.00, 250, 150),
('Non-Stick Pan', 2, 2, 899.00, 800, 80),
('Cotton T-Shirt', 3, 3, 499.00, 200, 300),
('Running Shoes', 5, 3, 2499.00, 600, 100),
('SQL for Beginners', 4, 5, 349.00, 400, 120),
('Yoga Mat', 5, 2, 799.00, 900, 90),
('Smartphone Stand', 1, 1, 299.00, 100, 250),
('Ceramic Mug Set', 2, 2, 649.00, 700, 60),
('Denim Jacket', 3, 3, 1799.00, 500, 70);

INSERT INTO orders (customer_id, order_date, order_status, delivered_date) VALUES
(1, '2025-01-05 10:30:00', 'delivered', '2025-01-09 14:00:00'),
(2, '2025-01-07 12:00:00', 'delivered', '2025-01-11 16:20:00'),
(3, '2025-01-10 09:15:00', 'shipped', NULL),
(4, '2025-01-12 18:45:00', 'delivered', '2025-01-16 11:00:00'),
(1, '2025-01-15 08:00:00', 'processing', NULL),
(5, '2025-01-18 20:10:00', 'delivered', '2025-01-22 09:30:00'),
(6, '2025-01-20 13:25:00', 'cancelled', NULL),
(7, '2025-01-22 17:40:00', 'delivered', '2025-01-26 10:15:00'),
(2, '2025-01-25 11:05:00', 'pending', NULL),
(8, '2025-01-28 19:50:00', 'delivered', '2025-02-01 12:00:00');

INSERT INTO order_items (order_id, product_id, quantity, unit_price, freight_value) VALUES
(1, 1, 2, 599.00, 40.00),
(1, 8, 1, 299.00, 20.00),
(2, 2, 1, 1999.00, 50.00),
(3, 4, 3, 499.00, 30.00),
(4, 5, 1, 2499.00, 60.00),
(4, 6, 2, 349.00, 25.00),
(5, 3, 1, 899.00, 35.00),
(6, 7, 1, 799.00, 30.00),
(7, 9, 2, 649.00, 40.00),
(8, 10, 1, 1799.00, 45.00),
(9, 1, 1, 599.00, 20.00),
(10, 2, 1, 1999.00, 50.00),
(10, 6, 1, 349.00, 20.00);

INSERT INTO payments (order_id, payment_type, installments, payment_value, payment_date) VALUES
(1, 'credit_card', 3, 1238.00, '2025-01-05 10:35:00'),
(2, 'upi', 1, 2049.00, '2025-01-07 12:05:00'),
(3, 'debit_card', 1, 1527.00, '2025-01-10 09:20:00'),
(4, 'credit_card', 6, 3233.00, '2025-01-12 18:50:00'),
(5, 'cod', 1, 934.00, '2025-01-15 08:05:00'),
(6, 'net_banking', 1, 829.00, '2025-01-18 20:15:00'),
(7, 'upi', 1, 1338.00, '2025-01-22 17:45:00'),
(8, 'credit_card', 4, 1844.00, '2025-01-22 17:50:00'),
(9, 'debit_card', 1, 619.00, '2025-01-25 11:10:00'),
(10, 'upi', 1, 2418.00, '2025-01-28 19:55:00');

INSERT INTO reviews (order_id, customer_id, review_score, review_comment, review_date) VALUES
(1, 1, 5, 'Great quality and fast delivery.', '2025-01-10 10:00:00'),
(2, 2, 4, 'Good product, packaging could be better.', '2025-01-12 09:00:00'),
(4, 4, 5, 'Exactly as described, very happy.', '2025-01-17 15:00:00'),
(6, 5, 3, 'Average quality for the price.', '2025-01-23 11:00:00'),
(8, 7, 4, 'Satisfied with the purchase.', '2025-01-27 10:30:00'),
(10, 8, 5, 'Excellent! Will buy again.', '2025-02-02 08:00:00');

-- ============================================================
-- SECTION 3: PRACTICE QUERIES (FULL SQL SYLLABUS)
-- ============================================================

-- 3.1 Basic SELECT, WHERE, ORDER BY, LIMIT
SELECT * FROM customers WHERE state = 'Maharashtra' ORDER BY first_name;
SELECT product_name, price FROM products WHERE price > 500 ORDER BY price DESC LIMIT 5;

-- 3.2 DISTINCT
SELECT DISTINCT state FROM customers;

-- 3.3 Aggregate functions, GROUP BY, HAVING
SELECT order_status, COUNT(*) AS total_orders
FROM orders
GROUP BY order_status;

SELECT c.customer_id, CONCAT(c.first_name,' ',c.last_name) AS customer_name, SUM(p.payment_value) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY c.customer_id, customer_name
HAVING SUM(p.payment_value) > 1000
ORDER BY total_spent DESC;

-- 3.4 INNER JOIN
SELECT o.order_id, c.first_name, c.last_name, o.order_status
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;

-- 3.5 LEFT JOIN (customers with or without a review)
SELECT c.customer_id, c.first_name, r.review_score
FROM customers c
LEFT JOIN reviews r ON c.customer_id = r.customer_id;

-- 3.6 Multi-table JOIN
SELECT o.order_id, p.product_name, oi.quantity, oi.unit_price, s.seller_name
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
JOIN sellers s ON p.seller_id = s.seller_id;

-- 3.7 Subquery - customers who spent above the average
SELECT customer_id, customer_name, total_spent FROM (
    SELECT c.customer_id, CONCAT(c.first_name,' ',c.last_name) AS customer_name, SUM(p.payment_value) AS total_spent
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN payments p ON o.order_id = p.order_id
    GROUP BY c.customer_id, customer_name
) AS customer_totals
WHERE total_spent > (SELECT AVG(payment_value) FROM payments);

-- 3.8 Correlated subquery - products never ordered
SELECT product_name FROM products p
WHERE NOT EXISTS (
    SELECT 1 FROM order_items oi WHERE oi.product_id = p.product_id
);

-- 3.9 CTE (Common Table Expression)
WITH order_totals AS (
    SELECT order_id, SUM(quantity * unit_price) AS order_value
    FROM order_items
    GROUP BY order_id
)
SELECT o.order_id, c.first_name, ot.order_value
FROM order_totals ot
JOIN orders o ON ot.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
ORDER BY ot.order_value DESC;

-- 3.10 Window function - rank customers by total spend
SELECT customer_id, total_spent,
       RANK() OVER (ORDER BY total_spent DESC) AS spend_rank
FROM (
    SELECT c.customer_id, SUM(p.payment_value) AS total_spent
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN payments p ON o.order_id = p.order_id
    GROUP BY c.customer_id
) t;

-- 3.11 Window function - running total of payments by date
SELECT payment_date, payment_value,
       SUM(payment_value) OVER (ORDER BY payment_date) AS running_total
FROM payments;

-- 3.12 CASE statement
SELECT order_id,
       CASE
           WHEN order_status = 'delivered' THEN 'Completed'
           WHEN order_status = 'cancelled' THEN 'Cancelled'
           ELSE 'In Progress'
       END AS order_summary
FROM orders;

-- 3.13 String functions
SELECT UPPER(product_name) AS product_upper, SUBSTRING(product_name,1,5) AS short_name
FROM products;

-- 3.14 Date functions
SELECT order_id, order_date, delivered_date,
       DATEDIFF(delivered_date, order_date) AS days_to_deliver
FROM orders
WHERE delivered_date IS NOT NULL;

-- 3.15 UNION - all cities across customers and sellers
SELECT city FROM customers
UNION
SELECT city FROM sellers;

-- 3.16 VIEW - order summary
CREATE OR REPLACE VIEW vw_order_summary AS
SELECT o.order_id, c.first_name, c.last_name, o.order_status,
       SUM(oi.quantity * oi.unit_price) AS order_total
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id, c.first_name, c.last_name, o.order_status;

SELECT * FROM vw_order_summary;

-- 3.17 STORED PROCEDURE - get all orders for a customer
DELIMITER $$
CREATE PROCEDURE GetCustomerOrders(IN cust_id INT)
BEGIN
    SELECT o.order_id, o.order_date, o.order_status
    FROM orders o
    WHERE o.customer_id = cust_id;
END $$
DELIMITER ;

CALL GetCustomerOrders(1);

-- 3.18 TRIGGER - reduce stock quantity after an order item is inserted
DELIMITER $$
CREATE TRIGGER trg_reduce_stock
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
    UPDATE products
    SET stock_quantity = stock_quantity - NEW.quantity
    WHERE product_id = NEW.product_id;
END $$
DELIMITER ;

-- 3.19 INDEXES for performance
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_orderitems_product ON order_items(product_id);

-- 3.20 EXISTS - customers who have placed at least one order
SELECT first_name, last_name FROM customers c
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id);
