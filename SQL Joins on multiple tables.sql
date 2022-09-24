use sakila;


    -- 1. Write a query to display for each store its store ID, city, and country.
    
    SELECT * 
    FROM store;  		-- Table 1
    
    SELECT * 
    FROM address;		-- Table 2
    
    SELECT * 
    FROM city;			-- Table 3
    
    SELECT * 
    FROM country;		-- Table 4
    
    SELECT store_id,city,country
    FROM sakila.store as s
    INNER JOIN sakila.address as a
    ON s.address_id = a.address_id
    INNER JOIN sakila.city as c
    ON a.city_id = c.city_id
    LEFT JOIN sakila.country as co
    ON c.country_id = co.country_id
    ;
    
      
    -- 2. Write a query to display how much business, in dollars, each store brought in.
    
    SELECT * 
    FROM store;  		-- Table 1
    
    SELECT * 
    FROM staff;			-- Table 2. By store_id with table 1
    
    SELECT * 
    FROM payment;		-- Table 3. By staff_id with table 2
    
    
    SELECT s.store_id,sum(amount) as Amount_store
    FROM sakila.store as s
    INNER JOIN sakila.staff as t
    ON s.store_id = t.store_id
    LEFT JOIN sakila.payment as p
    ON t.staff_id = p.staff_id
    GROUP BY s.store_id
    ;
    
           
    -- 3. What is the average running time of films by category?
	SELECT * 
    FROM film;  		-- Table 1
    
    SELECT * 
    FROM film_category;	-- Table 2. By film_id with table 1
    
    SELECT * 
    FROM category;		-- Table 3. By category_id with table 2
    
    
    SELECT ct.name,avg(length) as running_time
    FROM sakila.film as f
    INNER JOIN sakila.film_category as c
    ON f.film_id = c.film_id
    INNER JOIN sakila.category as ct
    ON c.category_id = ct.category_id
    GROUP BY name;
    

    
    -- 4. Which film categories are longest?
    
    SELECT ct.name,avg(length) as running_time
    FROM sakila.film as f
    INNER JOIN sakila.film_category as c
    ON f.film_id = c.film_id
    INNER JOIN sakila.category as ct
    ON c.category_id = ct.category_id
    GROUP BY name
    ORDER BY running_time DESC;
    
    -- 5. Display the most frequently rented movies in descending order
    
    SELECT * 
    FROM film;  		-- Table 1
    
    SELECT * 
    FROM inventory;	     -- Table 2. By film_id with table 1
    
    SELECT * 
    FROM rental;		-- Table 3. By inventory_id with table 2
    
    SELECT title, count(title) as frequency
    FROM sakila.film as f
    INNER JOIN sakila.inventory as i
    ON f.film_id = i.film_id
    INNER JOIN sakila.rental as r
    ON i.inventory_id = r.inventory_id
    GROUP BY title
    ORDER BY frequency DESC;
    
            
    -- 6. List the top five genres in gross revenue in descending order
         
          
    SELECT name, sum(amount) as revenue
    FROM sakila.film as f
    INNER JOIN sakila.film_category as c
    ON f.film_id = c.film_id
    INNER JOIN sakila.category as ct
    ON c.category_id = ct.category_id
    INNER JOIN sakila.inventory as i
    ON f.film_id = i.film_id
    INNER JOIN sakila.rental as r
    ON i.inventory_id = r.inventory_id
    INNER JOIN sakila.payment as p
    ON r.customer_id = p.customer_id
    GROUP BY name 
    ORDER BY revenue DESC LIMIT 5
    ;
         
    
    -- 7. Is "Academy Dinosaur" available for rent from Store 1?
    
    SELECT * 
    FROM film;  		-- Table 1
    
    SELECT * 
    FROM inventory;	     -- Table 2. By film_id with table 1
    
    SELECT * 
    FROM store;		-- Table 3. By store_id with table 2
    
    SELECT title,s.store_id
    FROM sakila.film as f
    INNER JOIN sakila.inventory as i
    ON f.film_id = i.film_id
    INNER JOIN sakila.store as s
    ON i.store_id= s.store_id
    WHERE title = 'ACADEMY DINOSAUR'   -- YES. ACADEMY DINOSAUR is in both stores
    ;
