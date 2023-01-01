use bank;

-- Query 1. Get the id values of the first 5 clients from district_id with a value equals to 1.
SELECT client_id 
FROM client
WHERE district_id = 1
LIMIT 5;

-- Query 2. In the client table, get an id value of the last client where the district_id equals to 72.
SELECT client_id 
FROM client
WHERE district_id = 72
ORDER BY client_id desc
LIMIT 1;

-- Query 3. Get the 3 lowest amounts in the loan table.
SELECT amount 
FROM loan
ORDER BY AMOUNT asc
LIMIT 3;

-- Query 4. What are the possible values for status, ordered alphabetically in ascending order in the loan table?
SELECT distinct status 
FROM loan
ORDER BY status;

-- Query 5. What is the loan_id of the highest payment received in the loan table?
SELECT loan_id
FROM loan
ORDER BY payments desc
LIMIT 1;

-- Query 6. What is the loan amount of the lowest 5 account_ids in the loan table? Show the account_id and the corresponding amount
SELECT account_id, amount
FROM loan
ORDER BY account_id asc
LIMIT 5;

-- Query 7. What are the account_ids with the lowest loan amount that have a loan duration of 60 in the loan table?
SELECT account_id, amount, duration
FROM loan
WHERE duration = 60
ORDER BY amount asc
LIMIT 5;

-- Query 8. What are the unique values of k_symbol in the order table?
SELECT distinct k_symbol
FROM bank.order
ORDER BY k_symbol ASC ;

-- Query 9. In the order table, what are the order_ids of the client with the account_id 34?
SELECT order_id
FROM bank.order
WHERE account_id = 34;

-- Query 10. In the order table, which account_ids were responsible for orders between order_id 29540 and order_id 29560 (inclusive)?
SELECT distinct account_id
FROM bank.order
WHERE (order_id BETWEEN 29540 AND 29560);

-- Query 11. In the order table, what are the individual amounts that were sent to (account_to) id 30067122?
SELECT amount
FROM bank.order
WHERE account_to = 30067122;

-- Query 12. In the trans table, show the trans_id, date, type and amount of the 10 first transactions from account_id 793 in chronological order, from newest to oldest.
SELECT trans_id, date, type,amount
FROM trans
WHERE account_id =793
ORDER BY date desc
LIMIT 10;

-- Query 13. In the client table, of all districts with a district_id lower than 10, how many clients are from each district_id? Show the results sorted by the district_id in ascending order.
SELECT district_id,count(*)
FROM client
WHERE district_id < 10
GROUP BY district_id
ORDER BY district_id asc;

-- Query 14. In the card table, how many cards exist for each type? Rank the result starting with the most frequent type
SELECT type, count(*)
FROM card
GROUP BY type;

-- Query 15. Using the loan table, print the top 10 account_ids based on the sum of all of their loan amounts.

SELECT account_id, sum( amount)
FROM loan
GROUP BY account_id
ORDER BY sum( amount) DESC
LIMIT 10;

-- Query 16. In the loan table, retrieve the number of loans issued for each day, before (excl) 930907, ordered by date in descending order.
SELECT date, count(*)
FROM loan
GROUP BY date
HAVING date<930907
ORDER BY date desc ;


-- Query 17.In the loan table, for each day in December 1997, count the number of loans issued for each unique loan duration, ordered by date and duration, both in ascending order. 
-- You can ignore days without any loans in your output.
SELECT date, duration, count(*)
FROM loan
GROUP BY date
HAVING date BETWEEN 971201 AND 980101
ORDER BY date and duration asc;


-- Query 18. In the trans table, for account_id 396, sum the amount of transactions for each type (VYDAJ = Outgoing, PRIJEM = Incoming)
-- Your output should have the account_id, the type and the sum of amount, named as total_amount. Sort alphabetically by type.

SELECT account_id, type, sum(amount)
FROM trans
WHERE account_id = 396
GROUP BY type;

-- Query 19. From the previous output, translate the values for type to English, rename the column to transaction_type, round total_amount down to an integer
SELECT *
FROM trans;

SELECT account_id,  floor(sum(amount)) as total_amount,
CASE 
	WHEN type = "PRIJEM" THEN "INCOMING"
    WHEN type = "VYDAJ" THEN "OUTGOING"
END as transaction_type
FROM trans
WHERE account_id = 396
GROUP BY type;

-- Query 20. From the previous result, modify your query so that it returns only one row, with a column for incoming amount, outgoing amount and the difference.
SELECT account_id, type, floor(sum(amount)) as total_amount
FROM trans
WHERE account_id = 396
GROUP BY type;

SELECT account_id,  
CASE 
	WHEN floor(sum(amount)) = "1028138" THEN "1028138" 
END as total_amount1,
CASE 
	WHEN floor(sum(amount)) = "1485814" THEN "1485814" 
END as total_amount2
FROM trans
WHERE account_id = 396
GROUP BY type;


