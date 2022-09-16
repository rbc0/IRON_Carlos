## SQL Queries 5
use sakila;
select * from staff; -- We check the table


-- 1 Drop column picture from staff.

alter table staff drop column picture; -- Dropped


-- 2 A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.

insert into staff (staff_id,first_name,last_name)
values (3,'TAMMY','SANDERS');

-- This delivers the following error: Error Code: 1364. Field 'address_id' doesn't have a default value
-- We try a new approach using all field names

insert into staff 
values (3,'TAMMY','SANDERS', 5, "---",3,1, "---","---","");

-- Error Code: 1292. Incorrect datetime value: '' for column 'last_update' at row 1




-- 3 Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1.
select * from rental;

-- Before adding a new row in rental table, we would need to find out customer_id,inventory_id,film_id and staff_id

select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER'; --  customer_id = 130

select film_id from sakila.film
where title = 'ACADEMY DINOSAUR'; -- film_id = 1

select staff_id from sakila.staff
where  first_name = 'Mike' and last_name = 'Hillyer'; -- staff_id = 1

select inventory_id from sakila.inventory
where film_id = 1 and store_id = 1; -- inventory_id = 1

-- With this information we can add a new row in rental table:

select * from rental order by rental_id desc limit 10;

insert into rental
values (16050, "2022-09-14 22:04:30", 1, 130,"2022-09-15 12:04:30" , 1, "2022-09-15 16:04:30");



-- 4 Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted.

--  Check if there are any non-active users

select count(*) from customer where active = 0; -- there are 15 non active users


--  Create a table backup table as suggested
select customer_id,email,create_date from customer where active = 0; -- check the table with non active users


drop table if exists deleted_users;	-- Step 1: We drop table in case it already exists
create table deleted_users (        -- Step 2: We create the structure of the backup table
customer_id integer(3),
email text(30),
create_date datetime
);

--  Insert the non active users in the table backup table

insert into sakila.deleted_users	-- Step 3: We enter all the requested info of non active users
select customer_id,email,create_date from sakila.customer where active = 0;

select * from sakila.deleted_users;	-- We check that the table is ok


--  Delete the non active users from the table customer

delete from sakila.customer where active = 0;









