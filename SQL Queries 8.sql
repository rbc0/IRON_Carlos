
USE sakila;

    -- 1 Rank films by length (filter out the rows with nulls or zeros in length column).
    -- Select only columns title, length and rank in your output.

SELECT * 
FROM film;

SELECT title, length,
DENSE_RANK() OVER(
	ORDER BY length DESC) rank_length
FROM film;
    
SELECT title, length,
DENSE_RANK() OVER(
	ORDER BY length DESC) rank_length
FROM film
WHERE length IS NOT NULL AND length != 0;
    
    
    -- 2 Rank films by length within the rating category (filter out the rows with nulls or zeros in length column).
    -- In your output, only select the columns title, length, rating and rank.
    
  SELECT title, rating, length,
DENSE_RANK() OVER(
	PARTITION BY rating
	ORDER BY length DESC) rank_length
FROM film
WHERE length IS NOT NULL AND length != 0;  
    
    
        
    -- 3 How many films are there for each of the categories in the category table? 
    -- Hint: Use appropriate join between the tables "category" and "film_category".
    
    SELECT *
    FROM category;
    
    SELECT *
    FROM film_category;
    
    SELECT name,COUNT(*)
    FROM sakila.category as c
    JOIN sakila.film_category as f
    ON c.category_id = f.category_id
    GROUP BY (name);
        
        
    -- 4 Which actor has appeared in the most films? 
    -- Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
    
    SELECT *
    FROM actor;
    
    SELECT *
    FROM film_actor;
    
    SELECT first_name,COUNT(*) as times
    FROM sakila.actor as a
    JOIN sakila.film_actor as f
    ON a.actor_id = f.actor_id
    GROUP BY (first_name) 
    ORDER BY times DESC limit 1;
  
    
       
    -- 5 Which is the most active customer (the customer that has rented the most number of films)?
    -- Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.

SELECT *
    FROM customer;
    
    SELECT *
    FROM rental;

SELECT first_name, last_name, COUNT(rental_id) as rentals
    FROM sakila.customer as c
    INNER JOIN sakila.rental as r
    ON c.customer_id = r.customer_id
    GROUP BY (first_name) 
    ORDER BY rentals DESC limit 1;
    
    
    
    
