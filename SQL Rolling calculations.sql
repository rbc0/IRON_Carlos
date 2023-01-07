use sakila;


# 1. Get number of monthly active customers.

-- We use two tables: customer and rental

-- Steps
SELECT * 
FROM customer;  -- Here we can see active customers

SELECT *
FROM rental;

SELECT customer_id, rental_date
FROM rental;

-- We know get months and years

SELECT customer_id,DATE_FORMAT(rental_date, '%M') as act_month, DATE_FORMAT(rental_date, '%Y') AS act_year
FROM rental
ORDER BY customer_id;

-- We know group them
SELECT COUNT(DISTINCT customer_id) AS act_us,DATE_FORMAT(rental_date, '%M') as act_month, DATE_FORMAT(rental_date, '%Y') AS act_year
FROM rental
GROUP BY act_year,act_month
ORDER BY act_year,act_month;

-- We now integrate this

CREATE OR REPLACE VIEW month_activ AS
	SELECT COUNT(DISTINCT customer_id) AS act_us,DATE_FORMAT(rental_date, '%M') as act_month, DATE_FORMAT(rental_date, '%Y') AS act_year
    FROM rental
	GROUP BY act_year,act_month
	ORDER BY act_year,act_month ASC;

SELECT *
FROM month_activ;

# 2. Active users in the previous month.
# From the previous view
SELECT act_year, act_month, act_us,LAG(act_us) OVER (ORDER BY act_year,act_month) as last_month_ac_us
FROM month_activ;


# 3. Percentage change in the number of active customers.
-- We create a new view
CREATE OR REPLACE VIEW month_activ_amp AS
	SELECT act_year, act_month, act_us,LAG(act_us) OVER (ORDER BY act_year,act_month) as last_month_ac_us
	FROM month_activ;

SELECT *
FROM month_activ_amp;

SELECT act_year,act_month, ROUND(100*(last_month_ac_us - act_us)/last_month_ac_us,2) AS ac_us_perc_change
FROM month_activ_amp;

# 4. Retained customers every month.

SELECT act_year,act_month, (act_us - last_month_ac_us) AS retained_users
FROM month_activ_amp;

