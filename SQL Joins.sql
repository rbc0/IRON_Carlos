
USE sakila;

    -- 1 List the number of films per category.
    SELECT * 
    FROM film;          -- First table
    
    SELECT * 
    FROM film_category; -- Second table
    
    SELECT f.film_id,title,category_id
    FROM sakila.film as f
    LEFT JOIN sakila.film_category as c
    ON f.film_id = c.film_id
    ORDER BY category_id ASC;
    
    
    -- 2 Display the first and the last names, as well as the address, of each staff member.
    
    SELECT * 
    FROM staff;
    
    SELECT * 
    FROM address;
    
    SELECT first_name,last_name,address 
    FROM sakila.staff s
    JOIN sakila.address a
    ON s.address_id = a.address_id;
    
    
    -- 3 Display the total amount rung up by each staff member in August 2005.
    
    SELECT *
    FROM payment;		-- First Table
    
    SELECT * 
    FROM staff;			-- Second Table
    
    SELECT DATE(payment_date)
    FROM payment;
    
    SELECT first_name,last_name,sum(amount) as total
    FROM sakila.payment p
    JOIN sakila.staff s
    ON p.staff_id = s.staff_id
    WHERE DATE(payment_date) > '2005-07-31' AND DATE(payment_date) < '2005-09-01'
    GROUP BY first_name;
    
    
      
    
    -- 4 List all films and the number of actors who are listed for each film.
    
    SELECT *
    FROM actor;   -- Table 1
    
    SELECT *
    FROM film_actor;   -- Table 2
    
    SELECT *
    FROM film;   -- Table 3
    
    SELECT *
    FROM sakila.actor a
    LEFT JOIN sakila.film_actor f
    ON a.actor_id = f.actor_id
    LEFT JOIN sakila.film m
    ON f.film_id = f.film_id;
    
    SELECT *
    FROM sakila.actor a
    JOIN sakila.film_actor f
    ON a.actor_id = f.actor_id
    LEFT JOIN sakila.film m
    ON f.film_id = f.film_id
    ;
    
    
    -- 5 Using the payment and the customer tables as well as the JOIN command, list the total amount paid by each customer. List the customers alphabetically by their last names.
    
    SELECT *
    FROM payment;   -- Table 1
    
     
    
    SELECT *
    FROM customer;   -- Table 2
    
    
    SELECT p.customer_id,first_name,last_name,amount, sum(amount) as total   -- Query
    FROM sakila.payment p
    JOIN sakila.customer c
    ON p.customer_id = c.customer_id
    GROUP BY p.customer_id;
    

SELECT sum(amount)
    FROM payment
    WHERE customer_id = 1;  -- Sanity check. we see how much does customer_id spent
    
    
    
