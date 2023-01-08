-- Lab- aggregation Revisited - Subqueries

use sakila;

# 1. Select the first name, last name, and email address of all the customers who have rented a movie.

-- For this we use Customer and rental tables

-- We check the tables
SELECT *
FROM customer;

SELECT *
FROM rental;

SELECT customer_id,first_name,last_name,email
FROM 	(SELECT *
		FROM customer)sub1
WHERE customer_id IN (SELECT customer_id
					FROM rental);


# 2. What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).
-- We now use Payment and Customer tables

-- We check the tables
SELECT *
FROM customer;

SELECT *
FROM payment;

-- We join tables
SELECT c.customer_id,first_name,last_name,amount
FROM customer as c
INNER JOIN payment as p 
ON c.customer_id = p.customer_id;

-- Finally we create the query
SELECT customer_id,CONCAT(first_name," ",last_name) AS name, ROUND(AVG(amount),2) AS avg_pay
FROM (SELECT c.customer_id,first_name,last_name,amount
	FROM customer as c
	INNER JOIN payment as p 
	ON c.customer_id = p.customer_id) sub1
GROUP BY customer_id;


# 3. Select the name and email address of all the customers who have rented the "Action" movies.

# Write the query using multiple join statements
-- We need the following tables: customer, rental,inventory,film, film_category and category
-- From category we get "Action" and category_id.With category_id we get film_id from film_category table. 
-- With film_id we get inventory_id from Inventory table. With inventory_id we get customer_id from rentals table. With customer_id we get required fields from customer table

-- We create a Query out of Joins:



SELECT first_name,last_name,email
FROM customer
JOIN rental USING (customer_id)
JOIN inventory USING (inventory_id)
JOIN film_category USING (film_id)
JOIN category USING (category_id)
WHERE name = "Action"
ORDER BY first_name ASC;


# Write the query using sub queries with multiple WHERE clause and IN condition

-- Step 1: This is the basic query for two tables
SELECT first_name,last_name,email
FROM customer
WHERE customer_id IN (
	SELECT customer_id 
    FROM rental);

-- Step 2: We just need to expand this to all tables

SELECT first_name,last_name,email
FROM customer
WHERE customer_id IN (
	SELECT customer_id 
    FROM rental
	WHERE inventory_id IN (
		SELECT inventory_id
        FROM inventory
        WHERE film_id IN(
			SELECT film_id
			FROM film_category
            WHERE category_id IN(
				SELECT category_id
				FROM category
				WHERE name = "Action"))))
ORDER BY first_name ASC;



# Verify if the above two queries produce the same results or not

-- Both tables do not match exactly



## 4. Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment.
##  If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.

-- We use payment table

SELECT *
FROM payment;

SELECT *,
CASE
	WHEN amount < 2 THEN "Low"
    WHEN amount BETWEEN 2 AND 4  THEN "Medium"
    WHEN amount >=4 THEN "High"
END AS "Label"
FROM payment;


