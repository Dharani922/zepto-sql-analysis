
use zepto_project;
SELECT * FROM zepto_project.zepto;
--------------------------------------------------
#data exploration

#add id as primary key
alter table zepto_project.zepto add column 
id int auto_increment primary key;

#rename name to product_name for understanding
alter table zepto_project.zepto 
rename column name to product_name;

 
#check all records are there or not

select count(*) from zepto_project.zepto;

#sample data
select * from zepto_project.zepto 
limit 10;

#check null values

select * from zepto_project.zepto 
where product_name is null
or mrp is null
or category is null
or discountPercent is null
or availableQuantity is null
or discountedSellingPrice is null
or weightInGms is null
or outOfStock is null
or quantity is null;

#different product category

select distinct category from
zepto_project.zepto 
order by category;

#products in-stock vs out-stock

select outofstock,count(id)as count from
zepto_project.zepto 
group by outofstock;

#product name present multiple times

select product_name,count(id)as no_of_times_rept from 
zepto_project.zepto 
group by product_name 
having count(id)>1
order by no_of_times_rept desc;

-----------------------------------------------------------------------------
#data cleaning
#sample_data
select * from zepto_project.zepto 
limit 10;

#find products with price 0

select product_name,mrp from
zepto_project.zepto 
where mrp=0 or discountedsellingprice=0;

#delete the record which price is 0

set sql_safe_updates=0;

delete from zepto where mrp=0;

set sql_safe_updates=1;

#convert mrp and discountsellingprice to rupees it was in paise
set sql_safe_updates=0;
START TRANSACTION;

update zepto_project.zepto set mrp=mrp/100.0,
discountedsellingprice=discountedsellingprice/100.0 ;

select mrp,discountedsellingprice from zepto_project.zepto;

commit;
set sql_safe_updates=1;

 

-- ================================
-- PROBLEM 1: Category-wise Revenue
-- ================================

#Identify which category generates the highest revenue

select category,sum(discountedsellingprice*availablequantity)as revenue
from zepto
group by category 
order by revenue desc limit 5;

-- Result: Cooking Essentials,Munchies,Personal Care,Paan Corner,Packaged Food these are the top 5 category with highest revenue
-- Insight:
-- These categories have strong demand and contribute significantly to overall revenue.
-- ===================================================================================================================================

-- =========================================
-- PROBLEM: Potential Revenue Risk (Stock-Out)
-- =========================================

-- Business Problem:
-- Identify high-value products that are currently unavailable

select category,product_name,mrp,outofstock
from zepto
where outofstock = "True" and mrp > 500
order by mrp desc;

-- Result:
-- Expensive products like Cooking Essentials and Munchies are not available

-- Insight: Since these are high-priced products, their unavailability may lead to missed sales opportunities if there is customer demand.
-- ========================================================================================================================================
#PROBLEM 3:Are Discounts Given Effectively? 
-- Business Problem: Are discounts helping sales or hurting profit?

select category,avg(discountpercent)as avg_discount ,sum(discountedsellingprice*availablequantity)as revenue,
case
    when avg(discountpercent) >15 and sum(discountedsellingprice*availablequantity) > 100000 then "effective"
    else
    "not effective"
    end as discount_effectiveness
from zepto
group by category;

-- Result: The analysis shows that there is no strong positive relationship between discount percentage and revenue across categories. 

-- For example, Fruits & Vegetables have a higher average discount (~15%) but generate relatively low revenue (~10,846), whereas categories like Cooking Essentials generate significantly higher revenue (~337,131) despite offering lower discounts (~7%). This indicates that higher discounts do not necessarily lead to higher revenue.

-- INSIGHTS: “Across categories, I observed that even moderate discounts (up to ~15%) did not significantly improve revenue,
-- indicating that discounting alone is not an effective strategy to drive sales.”

-- ============================================================
-- PROBLEM 4: Which products are performing below average?
-- ============================================================
select * from(
select category,product_name,mrp,(discountedSellingPrice*availableQuantity) as total_revenue,
avg(discountedsellingprice*availablequantity) over() as avg_revenue
from zepto) t
where total_revenue < avg_revenue 
order by total_revenue;

#RESULT:
-- Products with total revenue below the overall average are identified as underperforming. 
-- These products contribute less to the estimated revenue compared to other products in the dataset.
#INSIGHTS:
-- Some products generate significantly lower estimated revenue, which may indicate low demand, ineffective pricing, or poor inventory levels. These products may require strategic actions 
-- such as pricing adjustments, promotions, or removal from inventory.

select * from zepto_project.zepto 
limit 10;
-- ===================================================================
-- Which categories are frequently going out of stock?
-- ===================================================================

select category,count(*) as total_products,
sum(case when outofstock='true' then 1 else 0 end)as outofstock_products,
(sum(case when outofstock='true' then 1 else 0 end)*100.0/count(*)) as outofstock_percent
from zepto
group by category
order by outofstock_percent;

-- RESULT:Categories with higher stock-out percentage have more products unavailable frequently.

-- INSIGHTS:Categories with high stock-out rates indicate poor inventory management 
-- and may lead to missed sales opportunities.




