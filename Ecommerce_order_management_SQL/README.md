# E-Commerce Order Management System (MySQL)

A SQL portfolio project that demonstrates how to design a relational database, populate it with sample data, and practice SQL queries for e-commerce order management and business analysis.

## Project Overview

This project models the main operations of an online store, including customers, sellers, product categories, products, orders, order items, payments, and customer reviews. It includes sample records and example queries ranging from basic data retrieval to more advanced SQL features.

The schema is inspired by the structure of the [Brazilian E-Commerce (Olist) dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce). The sample data included in this SQL script is illustrative and should not be interpreted as the original Olist dataset.

## Objectives

- Design a relational database with primary and foreign key relationships.
- Insert sample data to test the schema.
- Retrieve and filter records using `SELECT`, `WHERE`, `ORDER BY`, and `LIMIT`.
- Analyze order and customer data using aggregate functions, `GROUP BY`, and `HAVING`.
- Combine related tables using joins and subqueries.
- Practice CTEs, window functions, `CASE`, string/date functions, and `UNION`.
- Create a view, stored procedure, trigger, and indexes.

## Database Schema

The script creates the database `ecommerce_order_management` and these tables:

| Table | Purpose |
|---|---|
| `customers` | Customer contact and location details |
| `sellers` | Seller names and locations |
| `product_categories` | Product category lookup |
| `products` | Product details, pricing, stock, and category/seller links |
| `orders` | Customer orders, status, and delivery dates |
| `order_items` | Products, quantities, unit prices, and freight per order |
| `payments` | Payment method, installments, value, and date |
| `reviews` | Customer review scores, comments, and dates |

### Main Relationships

- One customer can place many orders.
- One order can contain many order items.
- Each order item references a product.
- A product can reference a category and a seller.
- An order can have payment records and review records.
- Reviews reference both an order and a customer.

## SQL Concepts Covered

1. **Database and table creation** — `CREATE DATABASE`, `CREATE TABLE`, primary keys, foreign keys, `ENUM`, `CHECK`, and defaults.
2. **Basic queries** — `SELECT`, `WHERE`, `DISTINCT`, `ORDER BY`, and `LIMIT`.
3. **Aggregations** — `COUNT`, `SUM`, `GROUP BY`, and `HAVING`.
4. **Joins** — `INNER JOIN`, `LEFT JOIN`, and multi-table joins.
5. **Subqueries** — regular and correlated subqueries, including `EXISTS` and `NOT EXISTS`.
6. **CTEs** — `WITH` expressions for readable intermediate result sets.
7. **Window functions** — `RANK()` and running totals with `SUM() OVER (...)`.
8. **Conditional logic** — `CASE`.
9. **String and date functions** — `UPPER`, `SUBSTRING`, and `DATEDIFF`.
10. **Set operations** — `UNION`.
11. **Database objects** — a view, stored procedure, trigger, and indexes.

## Requirements

- MySQL 8.0 or later is recommended because the script uses window functions and CTEs.
- A MySQL client such as MySQL Workbench or the MySQL command-line client.

## How to Run

1. Download or clone this repository.
2. Open `ecommerce_order_management.sql` in MySQL Workbench, or connect using the MySQL CLI.
3. Execute the script from top to bottom.
4. The script creates and selects the `ecommerce_order_management` database, creates tables, inserts sample data, and runs practice queries.

### Run from the command line

```bash
mysql -u your_username -p < ecommerce_order_management.sql
```

Replace `your_username` with your MySQL username. Enter your password when prompted.

> **Important:** The script begins with `DROP DATABASE IF EXISTS ecommerce_order_management;`. Running it will delete and recreate that database if it already exists. Back up any important data before executing it.

## Example Business Questions

This project can be used to explore questions such as:

- Which customers are located in Maharashtra?
- What are the most expensive products?
- How many orders are in each status?
- Which customers have spent more than a specified amount?
- Which products have never been ordered?
- What is the order value by order?
- How do customers rank by total payment value?
- How many days did delivered orders take to arrive?
- Which customers have placed at least one order?

## Repository Structure

```text
.
├── README.md
└── ecommerce_order_management.sql
```

Save the SQL script in the repository using the filename `ecommerce_order_management.sql` (or update the command and tree above if you choose another filename).

## Notes and Limitations

- The inserted records are sample data for practice; they are not the full Olist dataset.
- The trigger reduces stock after an order item is inserted. The sample inserts run before the trigger is created, so those earlier inserts do not invoke it.
- The script is intended for learning and portfolio demonstration, not production deployment. A production system would need additional validation, transaction handling, permissions, and business rules.

## Author

Add your name and links here:

- **Name:** Rushikesh palade
- **GitHub:** https://github.com/rushikeshpalde02-zip
- **LinkedIn:** https://www.linkedin.com/in/RushikeshPalade

## License

No license has been specified. Add a license file if you want to define how others may use, modify, or distribute this project.
