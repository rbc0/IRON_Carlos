use sakila;

-- 1. Select all the actors with the first name ‘Scarlett’. 
select * from actor;

select * from actor where first_name = "Scarlett";

-- 2. Select all the actors with the last name ‘Johansson’.
select * from actor where last_name = "Johansson";

-- 3. How many films (movies) are available for rent?
select * from rental;
select count(inventory_id)  from rental; -- total inventory
select count(distinct(inventory_id)) from rental; -- total different films

-- 4. How many films have been rented? 
select * from rental;
select count(rental_id) from rental;

-- 5,6 What is the shortest and longest rental period?
select *,  min(return_date - rental_date)  from rental;
select *,  max(return_date - rental_date)  from rental;


-- 7 What's the average movie duration?
select * from film;
select avg(length) from film;

-- 8 What's the average movie duration expressed in format (hours, minutes)?
select avg(length)/60 from film;
select floor(avg(length)/60) as hours,((avg(length)/60)-1)*60 as minutes from film;

-- 9 How many movies longer than 3 hours?
select * from film;
select count(length) from film where length>180; 

-- 10. Get the name and email formatted
select * from customer;
select lcase(first_name),lcase(email) from customer;


-- 11. Whats the length of the longest film title?
select * from film;
select max(length(title)) from film;



