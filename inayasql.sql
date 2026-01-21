select * from customers
i. Top-selling products by revenue

SELECT p.productname,
       SUM(s.quantitysold * p.unitprice_INR * (1 - s.discountapplied/100)) AS total_revenue
FROM sales s
JOIN products p ON s.productid = p.ProductID
GROUP BY p.productname
ORDER BY total_revenue DESC
LIMIT 5
Least selling products
SELECT p.productname,
       SUM(s.quantitysold * p.unitprice_INR * (1 - s.discountapplied/100)) AS total_revenue
FROM sales s
JOIN products p ON s.productid = p.ProductID
GROUP BY p.productname
ORDER BY total_revenue asc
LIMIT 5

ii, Sales Performance by region wise

SELECT s.region,
       SUM(s.quantitysold * p.unitprice_inr) AS regional_sales
FROM sales s
JOIN products p
on p.productid=s.productid
GROUP BY s.region
ORDER BY regional_sales DESC

iii, Least-selling products by revenue

SELECT p.productname,
       SUM(s.quantitysold * p.unitprice_inr) AS total_revenue
FROM sales s
JOIN products p ON s.productid = p.productid
GROUP BY p.productname
ORDER BY total_revenue ASC
LIMIT 5

iv, Monthly revenue trend

select
extract(month from s.date) as month,
sum(s.quantitysold*p.unitprice_inr) as monthly_revenue
from
sales s
join products p
on p.productid=s.productid
group by 1
order by 1

v. impact od discount applied on revenue

select discountapplied,
sum(s.quantitysold*p.unitprice_inr) as revenue
from
sales s
join products p
on p.productid=s.productid
group by 1
order by 1

vi, Products about to go out of stock

SELECT p.productname,
 i.stock_level, i.reorderlevel
FROM inventory i
JOIN products p 
ON i.product_id = p.productid
WHERE i.stock_level <= i.reorderlevel;

vii, Top high valuse customer

SELECT c.name,
       SUM(s.quantitysold * p.unitprice_inr) AS high_value
FROM sales s
JOIN customers c 
ON s.customer_id = c.customer_id
join products p
on p.productid=s.productid
GROUP BY c.name
ORDER BY 2 DESC
LIMIT 5;

viii, Repeat vs one-time customers

SELECT c.customer_id,
COUNT(DISTINCT saleid) AS order_count
FROM sales s
join customers c
on s.customer_id=c.customer_id
GROUP BY customer_id
HAVING order_count = 1;

ix, Repeat customer

 SELECT c.customer_id,
COUNT(DISTINCT saleid) AS order_count
FROM sales s
join customers c
on s.customer_id=c.customer_id
GROUP BY customer_id
HAVING order_count > 1
order by 2 desc

x, Campaign performance analysis

SELECT 
m.campaign_id,
SUM(s.quantitysold * p.unitprice_inr) AS campaign_revenue
FROM sales s
JOIN marketing m
 ON m.product_id =s.productid
 join products p
 on p.productid=s.productid
GROUP BY 1
ORDER BY campaign_revenue DESC


