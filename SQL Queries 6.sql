
## SQL Queries 6

use sakila;

drop table if exists films_2020;
CREATE TABLE films_2020 (
  film_id smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  title varchar(255) NOT NULL,
  description text,
  release_year year(4) DEFAULT NULL,
  language_id tinyint(3) unsigned NOT NULL,
  original_language_id tinyint(3) unsigned DEFAULT NULL,
  rental_duration int(6),
  rental_rate decimal(4,2),
  length smallint(5) unsigned DEFAULT NULL,
  replacement_cost decimal(5,2) DEFAULT NULL,
  rating enum('G','PG','PG-13','R','NC-17') DEFAULT NULL,
  PRIMARY KEY (film_id),
  CONSTRAINT FOREIGN KEY (original_language_id) REFERENCES language (language_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1003 DEFAULT CHARSET=utf8;

SELECT * FROM films_2020;   -- We check the table

## Instructions

-- 1 Add the new films to the database.

LOAD DATA INFILE 'C:\Users\cprieto\Documents\Ironhack\2._\films_2020.csv' 
INTO TABLE films_2020 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Error Code: 1290. The MySQL server is running with the --secure-file-priv option so it cannot execute this statement
-- Let´s try with the Hint
show variables like 'local_infile';
set global local_infile = 1;

LOAD DATA INFILE 'C:\Users\cprieto\Documents\Ironhack\2._\films_2020.csv'   -- Here we go again
INTO TABLE films_2020 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

--   :-(   ......Still doesn´t work 
-- Let´s go with the "data import wizard"

SELECT *
FROM films_2020;   -- It works!!!

-- 2 Update information on rental_duration, rental_rate, and replacement_cost

UPDATE films_2020
SET
	rental_duration = '3'
WHERE
	rental_duration = '0';
    
-- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  


SHOW VARIABLES LIKE "sql_safe_updates"; -- we check if the safe update mode is ON----

-- To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect. We do this and now works

-- We now change the other two alter

UPDATE films_2020
SET
	rental_rate = '2.99'
WHERE
	rental_rate = '0.00';
    
    
    UPDATE films_2020
SET
	replacement_cost = '8.99'
WHERE
	replacement_cost = '0.00';
    
    
    -- Done

