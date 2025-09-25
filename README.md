# 🍕 Pizza Sales SQL Project  

## 📌 Project Overview  
This project contains a set of SQL queries designed to analyze a **Pizza Sales Database**.  
The analysis addresses key business questions such as **total revenue, most popular pizza types, customer ordering patterns, and category-wise performance**. 

## 📂 Project Structure  
- `Pizza_Sales_Database.sql` → Contains all SQL queries.  
- `README.md` → Documentation of the project.  
- `Schema_Diagram.png` → Database schema diagram (for reference).  
- `excel_files/` → Folder containing Excel files.

## 📊 Queries Overview  
Here are the **13 business questions** solved in this project:  

1. Retrieve the total number of orders placed.  
2. Calculate the total revenue generated from pizza sales.  
3. Identify the highest-priced pizza.  
4. Identify the most common pizza size ordered.  
5. List the top 5 most ordered pizza types along with their quantities.  
6. Find the total quantity of each pizza category ordered.  
7. Determine the distribution of orders by hour of the day.  
8. Find the category-wise distribution of pizzas.  
9. Calculate the average number of pizzas ordered per day.  
10. Determine the top 3 most ordered pizza types based on revenue.  
11. Calculate the percentage contribution of each pizza category to total revenue.  
12. Analyze the cumulative revenue generated over time.  
13. Find the top 3 most ordered pizza types (by revenue) for each pizza category.  

## 📝 Sample Queries

 **1. Total Number of Orders.**

```sql
SELECT 
    COUNT(*) AS total_orders
FROM
    orders;
```
    

**2. Total Revenue Generated.**

```sql
SELECT 
    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id;
```

    
**3. Highest Priced Pizza.**

```sql
SELECT 
    pt.name, p.price
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
ORDER BY p.price DESC
LIMIT 1;
```
📌 Note: Full queries are available in Pizza_Sales_Database.sql


## 📈 Key Findings

| Metric                      | Value                                                          |
| --------------------------- | -------------------------------------------------------------- |
| 💰 **Total Revenue**        | $817,860                                                       |
| 🍕 **Highest-Priced Pizza** | Greek Pizza ($35.95)                                           |
| 📏 **Most Popular Size**    | Large (18,956 orders)                                          |
| 🏆 **Top-Selling Pizzas**   | Classic Deluxe, BBQ Chicken, Hawaiian, Pepperoni, Thai Chicken |



## 📊 Key Insights:
- Total revenue generated: $817,860.
- Highest-priced pizza: Greek Pizza ($35.95).
- Most popular size: Large (18,956 orders).
- Top-selling pizzas: Classic Deluxe, BBQ Chicken, Hawaiian, Pepperoni, Thai Chicken.
- Found ordering patterns by hour & day, and tracked cumulative revenue growth.

✅ Conclusion

This project showcases SQL skills for real-world business analysis — from simple aggregations to advanced window functions (like cumulative revenue).

It can be extended by:
- Building dashboards in Power BI/Tableau
- Running predictive models on pizza sales trends
- Optimizing queries for performance on large datasets
