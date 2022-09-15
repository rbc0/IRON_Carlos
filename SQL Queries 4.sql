-- Instructions
use sakila;
-- 1 Get film ratings.
SELECT * FROM FILM; -- We check the table first

select title, rating from film; -- We get the rate for each film

-- 2 Get release years.
select title, release_year from film; -- We get the release date for each film

-- 3 Get all films with ARMAGEDDON in the title.

select title from film where title like '%ARMAGEDDON%'; -- We use "like" operator for this

-- 4 Get all films with APOLLO in the title
select title from film where title like '%APOLLO%';

-- 5 Get all films which title ends with APOLLO.
select title from film where title like '%APOLLO';

-- 6 Get all films with word DATE in the title.
select title from film where title like '% DATE%' OR title like 'DATE%'; -- We add 2 conditions for the like (startng by Date or having date ase second word

-- 7 Get 10 films with the longest title.
SELECT title,length(title) as title_length  FROM FILM order by length desc limit 10;

-- 8 Get 10 the longest films.
-- Not sure what the question is asking

-- 9 How many films include Behind the Scenes content?
select count(*) title,special_features from film where special_features like 'Behind the Scenes';

-- 10 List films ordered by release year and title in alphabetical order.
SELECT title,release_year
FROM film
ORDER by
	release_year DESC, -- First we order by release year
    title ASC          -- Then we order by title name
    ;
