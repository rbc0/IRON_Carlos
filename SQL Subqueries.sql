# Instructions

use sakila;

# 1. How many copies of the film Hunchback Impossible exist in the inventory system?

SELECT *
FROM  film;  -- We check table film

SELECT *
FROM inventory;  -- We now check table inventory


SELECT title,film_id					-- We get how many film we´ve got according to its film_id
FROM  film
WHERE title = "HUNCHBACK IMPOSSIBLE";   -- We get Fil_id = 439


SELECT  film_id,count(film_id) as Number_Copies    -- We check how many copies we have for every film in the inventory
FROM inventory
GROUP BY film_id;									

SELECT *
FROM (SELECT  film_id,count(film_id) as Number_Copies
		FROM inventory
        GROUP BY film_id) sub1
WHERE film_id = (SELECT film_id					
				FROM  film
				WHERE title = "HUNCHBACK IMPOSSIBLE")
;



# 2. List all films whose length is longer than the average of all the films.

SELECT *
FROM  film;		-- We check the table

SELECT  avg(length) as avg_length		-- We check avg length
FROM film;

SELECT title, length					-- We get table with films whose legth is longer than the average
FROM film
WHERE length > (SELECT avg(length) 
				FROM film);



# 3. Use subqueries to display all actors who appear in the film Alone Trip.

-- We´ve got 3 tables here to extract info: film, actor and film_actor. Let´s check the tables firs

SELECT *
FROM  film;		

SELECT *
FROM  actor;

SELECT *
FROM  film_actor;


-- We would need to see which actor_id ´s participated in "Alone Trip" movie in first place

SELECT film_id, title
FROM  film
WHERE title = "ALONE TRIP";            -- Film_id = 17

-- Now we would like to see which actor_id ´s worked in film_id = 17

SELECT actor_id, film_id
FROM  film_actor
WHERE film_id = (SELECT film_id
				FROM  film
				WHERE title = "ALONE TRIP");     	-- I beleive getting actor_id for the film would be enough but let´s get their names
                
-- Finally we just find actors names

SELECT first_name,last_name
FROM actor
WHERE actor_id in (SELECT actor_id
				FROM  film_actor
				WHERE film_id = (SELECT film_id
								FROM  film
								WHERE title = "ALONE TRIP"));



# 4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.

-- 3 Tables here: Film_category , Film & categorie
-- First we look for category_id for Family films

SELECT *
FROM film;

SELECT film_id, category_id
FROM film_category;

SELECT *
FROM category;

SELECT  category_id, category.name
FROM category
WHERE name = "Family";

-- Then we get film_id

SELECT film_id
FROM film_category
WHERE category_id =(SELECT  category_id
					FROM category
					WHERE name = "Family");
                    
-- Finally we get the titles

SELECT title
FROM film
WHERE film_id in (SELECT film_id
				FROM film_category
				WHERE category_id =(SELECT category_id
					FROM category
					WHERE name = "Family"));




# 5. Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, you will have to identify 
#    the correct tables with their primary keys and foreign keys, that will help you get the relevant information.


-- Table customer

SELECT *
FROM customer;

SELECT *
FROM city;

SELECT *
FROM country;

SELECT *
FROM address;

-- Through a Subquery

SELECT first_name, email
FROM customer
WHERE address_id in	(SELECT address_id
		FROM address
		WHERE city_id in (SELECT city_id
						FROM city
						WHERE country_id =(SELECT country_id
							FROM country
							WHERE country = "Canada")));
                            
                            

-- Through Join

SELECT first_name, email
FROM sakila.country as c
INNER JOIN sakila.city as t
ON c.country_id = t.country_id
INNER JOIN sakila.address as a
ON a.city_id = t.city_id
INNER JOIN sakila.customer as cu
ON cu.address_id = a.address_id
WHERE country= "Canada"
;



# 6. Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. 
#    First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.

## We will need the following tables
SELECT *
FROM actor;

SELECT *
FROM film_actor;

SELECT *
FROM film;

-- We check whose the most prolific actor by actor_id
SELECT actor_id, count(*) as number_films
FROM film_actor
GROUP BY actor_id
ORDER BY number_films DESC
;

## The most prolific actor is:
SELECT actor_id,first_name,last_name
FROM actor
WHERE actor_id in (SELECT count(*) as number_films
					FROM film_actor
					GROUP BY actor_id
					ORDER BY number_films DESC) 
LIMIT 1
;


-- Let´s check now which are films_id where actress "VIVIEN BERGEN" has participated insert
SELECT film_id
FROM film_actor
WHERE actor_id ="14"
;

-- Now we will get the titles of those film_id´s

SELECT film_id,title
FROM film
WHERE film_id in (SELECT film_id
				FROM film_actor
				WHERE actor_id ="14");

		

# 7. Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments

## We will need the following tables
SELECT *
FROM customer;

SELECT *
FROM payment;

SELECT *
FROM film;

-- Lets find customer that has paid the most by customer_id

SELECT customer_id, sum(amount) as total_paid  
FROM payment
GROUP BY customer_id
ORDER BY total_paid DESC
LIMIT 1;


SELECT customer_id, first_name,  last_name
FROM customer
WHERE customer_id in (SELECT  customer_id, sum(amount) as total_paid  
					FROM payment
					GROUP BY customer_id
					ORDER BY total_paid DESC
                    )
;




# 8. Get the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.
SELECT customer_id, SUM(amount) as total_paid
FROM payment as p
WHERE amount > (SELECT AVG(amount)
				FROM payment p2
				WHERE p.customer_id = p2.customer_id)
				GROUP BY customer_id
				ORDER BY total_paid DESC;