use sakila;

-- 1. How many distinct (different) actors' last names are there?

select * from actor;
select count(distinct last_name) from actor;

-- 2. In how many different languages where the films originally produced? (Use the column language_id from the film table)
select * from language;
select count(distinct name)from language;

-- 3. How many movies were released with "PG-13" rating?
select * from film;
select count(*) from film where rating = "PG-13";

-- 4. Get 10 the longest movies from 2006.

select title, length, substring(last_update,1,4) from film order by length desc limit 10;

-- 5. How many days has been the company operating (check DATEDIFF() function)?
select * from rental;
select datediff(max(rental_date),min(rental_date)) from rental;

-- 6. Show rental info with additional columns month and weekday. Get 20.
select * from rental;

select *, date_format(convert(rental_date,date),"%M") as rental_month, date_format(convert(rental_date,date),"%D") as rental_weekday from rental limit 20;

-- 7 Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
select * from rental;
select dayofweek(rental_date) from rental;
select *,  dayofweek(rental_date) as weekeday from rental;


-- 8 How many rentals were in the last month of activity?
select * from rental order by rental_date desc; -- Wew chack last month was Febraury 2006

select count(*) from rental where substring(rental_date,1,7) = "2006-02";



