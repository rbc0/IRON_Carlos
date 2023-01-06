## Self and Cross Joins

use sakila;

# 1. Get all pairs of actors that worked together.

SELECT *
FROM film_actor;

SELECT fa.actor_id as act1, fa2.actor_id as act2
FROM film_actor as fa
JOIN film_actor as fa2 on fa.film_id = fa2.film_id 
WHERE FA.actor_id <> fa2.actor_id
ORDER BY fa.actor_id;


# 2. Get all pairs of customers that have rented the same film more than 3 times.
# We use rental and inventory tables

SELECT *
FROM rental;  -- r

SELECT *
FROM inventory; -- i

-- first we get which clients have seen what and how many times


SELECT r.customer_id, i.film_id, count(rental_id) as rent
FROM rental r
LEFT JOIN inventory AS i ON i.inventory_id = r.inventory_id
GROUP BY r.customer_id, i.film_id
ORDER BY r.customer_id;

-- Second we get from this table those customers that rented the same film and then check which of them were rented more than 3 times

SELECT m.customer_id as cust_1, n.customer_id as cust2, m.film_id,m.rent
FROM (
	SELECT r.customer_id, i.film_id, count(rental_id) as rent
	FROM rental r
	LEFT JOIN inventory AS i ON i.inventory_id = r.inventory_id
	GROUP BY r.customer_id, i.film_id
	ORDER BY r.customer_id) m
LEFT JOIN (
	SELECT r.customer_id, i.film_id, count(rental_id) as rent
	FROM rental r
	LEFT JOIN inventory AS i ON i.inventory_id = r.inventory_id
	GROUP BY r.customer_id, i.film_id
	ORDER BY r.customer_id) n
ON m.film_id = n.film_id
WHERE m.rent  >2
GROUP BY m.customer_id
;

# 3. Get all possible pairs of actors and films
-- We use actor and film_actor tables

SELECT *
FROM actor;

SELECT *
FROM film_actor;
        
SELECT * 
FROM (
	SELECT DISTINCT first_name, last_name
    FROM actor
	) sub1
	CROSS JOIN (
	SELECT title
    FROM film
	) sub2; 