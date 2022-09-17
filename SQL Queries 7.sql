use sakila;

-- 1. In the table actor, which are the actors whose last names are not repeated? 

SELECT *
FROM sakila.actor;

SELECT first_name,last_name, count(last_name)  -- We see how many times last name is repeated for each last_name
FROM sakila.actor
GROUP BY last_name								 
HAVING count(last_name)<2
;

-- 2. Which last names appear more than once? 

SELECT last_name, count(last_name)  -- Same but with different "Having" condition
FROM sakila.actor
GROUP BY last_name								 
HAVING count(last_name)>1
;

-- 3 Using the rental table, find out how many rentals were processed by each employee.
SELECT * 
FROM rental;

SELECT staff_id, COUNT(staff_id)
FROM rental
GROUP BY staff_id;

-- 4 Using the film table, find out how many films were released each year.

SELECT release_year, COUNT(release_year)
FROM film
GROUP BY release_year;


-- 5 Using the film table, find out for each rating how many films were there.
SELECT rating, COUNT(rating)
FROM film
GROUP BY rating;


-- 6 What is the mean length of the film for each rating type. Round off the average lengths to two decimal places

SELECT rating, COUNT(rating),round(avg(length),2)
FROM film
GROUP BY rating;


-- 7 Which kind of movies (rating) have a mean duration of more than two hours?
SELECT rating, COUNT(rating) as total_films, round(avg(length),2) as avg_duration 
FROM film
GROUP BY rating
HAVING avg_duration>120;

