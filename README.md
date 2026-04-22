Zepto E-Commerce SQL Analysis

## Project Overview
In this project, I worked on Zepto’s product dataset to analyze pricing, discounts, and inventory. 
The main goal was to understand how revenue is generated and identify areas where the business can improve.

---

## Tools Used
- SQL (MySQL)

---

## Data Cleaning & Preparation
Before starting the analysis, I cleaned the dataset to make sure the results are accurate:

- Added a primary key (`id`) for unique identification  
- Renamed column `name` to `product_name` for better understanding  
- Checked for null/missing values in important columns  
- Removed records where price values were zero  
- Converted prices from paise to rupees  
- Verified data consistency using basic queries  

---

## Business Problems Solved

During this project, I focused on solving real business-related questions:

1. **Which categories generate the most revenue?**  
2. **Are there high-value products that are out of stock?**  
3. **Are discounts actually helping in increasing revenue?**  
4. **Which products are performing below average?**  
5. **Which categories frequently face stock issues?**

---

## Key Insights

- A few categories like *Cooking Essentials* and *Packaged Food* generate most of the revenue  
- Some high-priced products are out of stock, which may lead to missed opportunities  
- Discounts alone do not guarantee higher revenue  
- Some products perform below average due to pricing or low demand  
- Certain categories have more stock-out issues, indicating inventory problems  

---

## Business Recommendations

Based on the analysis, I suggest:

- Improve stock availability for high-value products  
- Optimize discount strategies instead of applying them everywhere  
- Focus more on high-performing categories  
- Re-evaluate pricing for underperforming products  
- Improve inventory management across categories  

---

## SQL Concepts Used

- Aggregations (`SUM`, `AVG`, `COUNT`)  
- `GROUP BY`, `HAVING`  
- `CASE WHEN`  
- Subqueries  
- Window functions (`AVG() OVER()`)  
- Data cleaning techniques  

---

## 📂 Project Structure

- `dataset/` → contains the dataset used for analysis  
- `sql/` → contains all SQL queries with business problems and insights  

---

## 🎯 Conclusion

This project helped me understand how to use SQL not just for querying data, 
but also for solving real-world business problems and generating useful insights.
