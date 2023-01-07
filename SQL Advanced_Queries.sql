-- SQL Advanced Queries
   -- 1. List each pair of actors that have worked together.
   -- We get it from film_actor table
   
   SELECT *
   FROM film_actor;
   
   -- We just need to do a Self Join here
   
   SELECT * 
   FROM film_actor as f1
   JOIN film_actor as f2 ON f1.film_id = f2.film_id;

-- And now we just need to delete those who are the same
   SELECT * 
   FROM film_actor as f1
   JOIN film_actor as f2 ON f1.film_id = f2.film_id
   WHERE f1.actor_id <> f2.actor_id
   ORDER BY f1.actor_id;

   
   -- 2. For each film, list actor that has acted in more films.
-- We check how many actors each film has 
SELECT film_id,count(film_id) AS actors_in_film
FROM film_actor
GROUP BY film_id
ORDER BY film_id;

-- We now rank actors by numebr of films they have been in
SELECT actor_id, COUNT(actor_id) as num_films
FROM film_actor
GROUP BY actor_id
ORDER BY actor_id ASC;

-- We create a View with each film_id and the number of films each actor has appeared in
SELECT *
FROM film_actor
WHERE actor_id in ( SELECT COUNT(actor_id) as num_films
					FROM film_actor
					GROUP BY actor_id
					ORDER BY actor_id ASC)
GROUP BY film_id				
ORDER BY film_id;



