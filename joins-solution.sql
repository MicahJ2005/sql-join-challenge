	--1.	Get all customers and their addresses.

SELECT * FROM customers
JOIN addresses on customers.id=addresses.customer_id;

	--2.	Get all orders and their line items (orders, quantity and product).
SELECT orders.id, line_items.quantity, products.description FROM orders
JOIN line_items on orders.id=line_items.order_id
JOIN products on line_items.product_id=products.id
GROUP BY orders.id, line_items.quantity, products.description 
ORDER BY orders.id;
	
	--3.	Which warehouses have cheetos?

SELECT warehouse.warehouse, products.description FROM warehouse_product
JOIN products on products.id=warehouse_product.product_id
JOIN warehouse on warehouse.id=warehouse_product.warehouse_id
WHERE products.description = 'cheetos'
GROUP BY warehouse.warehouse, products.description;
	
	--4.	Which warehouses have diet pepsi?
	
SELECT warehouse.warehouse, products.description FROM warehouse_product
JOIN products on products.id=warehouse_product.product_id
JOIN warehouse on warehouse.id=warehouse_product.warehouse_id
WHERE products.description = 'diet pepsi'
GROUP BY warehouse.warehouse, products.description;
	
	--5.	Get the number of orders for each customer. NOTE: It is OK if those without orders are not included in results.
	
SELECT customers.first_name, customers.last_name, COUNT(orders.address_id) FROM customers
JOIN addresses on addresses.customer_id = customers.id
JOIN orders on orders.address_id = addresses.id
GROUP BY customers.first_name, customers.last_name;
	
	--6.	How many customers do we have?
	
SELECT COUNT(customers.id) FROM customers;
	
	--7.	How many products do we carry?
	
SELECT COUNT(products.id) FROM products;
	
	--8.	What is the total available on-hand quantity of diet pepsi?
	
SELECT SUM(warehouse_product.on_hand), products.description FROM warehouse_product
JOIN products ON warehouse_product.product_id=products.id 
WHERE products.description = 'diet pepsi'
GROUP BY products.description;

	--9.	How much was the total cost for each order?

SELECT orders.id, SUM(products.unit_price*line_items.quantity) FROM line_items
JOIN orders ON line_items.order_id=orders.id
JOIN products ON line_items.product_id=products.id
GROUP BY orders.id ORDER BY orders.id ASC;
	
	--10.	How much has each customer spent in total?

SELECT customers.first_name, SUM(products.unit_price*line_items.quantity) FROM customers
JOIN addresses on addresses.customer_id = customers.id
JOIN orders on orders.address_id = addresses.id
JOIN line_items ON line_items.order_id=orders.id
JOIN products ON line_items.product_id=products.id
GROUP BY customers.first_name;	

	--11.	How much has each customer spent in total? Customers who have spent $0 should still show up in the table. It should say 0, not NULL (research coalesce).

SELECT customers.first_name, SUM(products.unit_price*line_items.quantity) FROM customers
JOIN addresses on addresses.customer_id = customers.id
JOIN orders on orders.address_id = addresses.id
JOIN line_items ON line_items.order_id=orders.id
JOIN products ON line_items.product_id=products.id
GROUP BY customers.first_name;