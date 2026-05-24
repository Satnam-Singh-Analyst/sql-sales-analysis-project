# Sales Analysis SQL Project

## Author
Satnam Singh

---

## Project Overview
This project is a **SQL-based Sales Analysis system** built using MySQL.  
It simulates real-world business data to analyze customers, products, orders, and revenue trends.

The project includes both **basic and advanced SQL analytics** such as joins, aggregations, CTEs, and window functions.

---

##  Database Structure

The database contains 4 main tables:

- **customers**
- **products**
- **orders**
- **order_items**

### Relationships:
- One customer → multiple orders  
- One order → multiple products  

---

## Project Objectives

- Analyze customer purchasing behavior  
- Identify top customers by spending  
- Track monthly revenue trends  
- Find best-selling products  
- Perform category-wise revenue analysis  
- Segment customers (repeat vs one-time)  
- Calculate revenue growth trends  

---

## Basic SQL Analysis

✔ Total spending per customer  
✔ Top 3 highest spending customers  
✔ Monthly revenue calculation  
✔ Product performance analysis  
✔ Category-wise revenue analysis  

---

## Advanced SQL Features Used

### 1. CTE (Common Table Expressions)
Used for breaking complex queries into simpler steps.

### 2. Window Functions
- `LAG()` → to calculate month-over-month revenue growth  
- `RANK()` → to find top products per category  
- `DENSE_RANK()` → customer ranking based on spending  
- Running total using window functions  

### 3. CASE WHEN
Used for customer segmentation:
- VIP Customers  
- Regular Customers  
- Low-value Customers  

---

## Advanced SQL Queries Implemented

###  1. Repeat vs One-Time Customers
- Classified customers based on number of orders

---

###  2. Monthly Revenue Growth Analysis
- Used `LAG()` to compare current vs previous month revenue  
- Calculated percentage growth

---

###  3. Top Product per Category
- Used `RANK()` to find best-selling product in each category  

---

###  4. Running Total Revenue
- Used window function to calculate cumulative sales over time  

---

###  5. Customer Ranking by Spending
- Used `DENSE_RANK()` to rank customers based on total spending  

---

## Key SQL Concepts Used

- SELECT, WHERE, GROUP BY  
- JOINs (INNER JOIN, LEFT JOIN)  
- Aggregate Functions (SUM, COUNT, AVG)  
- CASE WHEN statements  
- CTE (WITH clause)  
- Window Functions (LAG, RANK, DENSE_RANK)  
- Subqueries  

---

## Tools Used

- MySQL Workbench  
- SQL  

---

## Key Insights from Project

- Identified top revenue-generating customers  
- Found best-performing products  
- Analyzed monthly revenue trends  
- Measured customer loyalty (repeat customers)  
- Tracked business growth using window functions  

---

## Project Type
✔ Data Analysis Project  
✔ SQL Portfolio Project  
✔ Beginner to Intermediate to Advanced Level  

---

## Outcome

This project demonstrates strong SQL skills including:
- Business data analysis  
- Advanced querying techniques  
- Real-world analytics thinking  

---

## Conclusion

This project is suitable for:
- Data Analyst portfolio  
- SQL practice demonstration
