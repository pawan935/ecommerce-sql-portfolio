use eCommerce
go

select * from customers;


-----List all customers who joined in 2022.
select*
from customers
where YEAR(signup_date) = 2022

-----Show total number of customers.
select COUNT(*) as total_customers
from customers;

----Display all unique product categories.
select distinct category 
from products;

---List all products with price greater than 500
select product_name, price
from products
where price >500 ;

----Which product has the highest price? Show product name and category.
select top 1
product_name,max(price) as higest_price
from products
group by product_name


-------Count how many orders were placed in each year.
SELECT YEAR(order_date) AS order_year, COUNT(order_id) AS total_order
FROM orders
GROUP BY YEAR(order_date)
ORDER BY order_year;


-----Get the top 5 most expensive products.
SELECT TOP (5) product_name, price
FROM     products
ORDER BY price DESC

------Show the number of products in each category.
select category , count(product_name) as total_product
from products
group by category ;

---What is the average product price per category?
select category , AVG(price) as avr_price
from products
group by category
order by avr_price

------Which customer placed the highest number of orders?
select top (1) c.customer_id,sum(o.total_amount) as total_spent
from customers as c 
left join orders as o on c.customer_id = o.customer_id
group by c.customer_id
order by total_spent desc ;

------Show total revenue (sum of payments) per month.
select month(order_date) as months, SUM(total_amount) as revenue
from orders
group by MONTH(order_date)
order by MONTH(order_date);


------Which products have never been ordered?
SELECT p.product_name
FROM products AS p
LEFT JOIN order_items AS od ON p.product_id = od.product_id
WHERE od.order_id IS NULL;

----Find the most sold product (by quantity).
select top (1)
products.product_name , SUM(od.quantity) as total_count
from products
left join order_items as od on products.product_id = od.product_id
group by products.product_name
order by total_count desc ;

---Show each customer's total spend and number of orders.
select customers.customer_id ,
COUNT(orders.order_id) as count_sale,
SUM(orders.total_amount) as total_spend
from customers
left join orders on customers.customer_id = orders.customer_id
group by customers.customer_id
order by count_sale desc;

------Get product-wise revenue (sum of quantity × price)
select products.product_name ,
SUM ( products.price * order_items.quantity) as revenue
from products
join order_items on products.product_id = order_items.product_id
group by products.product_name
order by revenue desc;

----Which category has generated the most revenue?
select top (1) products.category , 
SUM(order_items.quantity *products.price) as category_sale
from products
join order_items on products.product_id = order_items.product_id
group by products.category 
order by category_sale desc;

------Rank customers by their total spending (use RANK() or DENSE_RANK()).
select customers.customer_id , customers.first_name ,
SUM(order_items.quantity * products.price) as total_spending,
dense_rank () over (order by SUM(order_items.quantity * products.price) desc) as spending_rank
from customers
JOIN 
  orders  ON customers.customer_id = orders.customer_id
JOIN 
  order_items  ON orders.order_id =  order_items.order_id
JOIN 
  products  ON  order_items.product_id =  products.product_id
GROUP BY 
  customers.customer_id , customers.first_name 
ORDER BY 
  spending_rank;














