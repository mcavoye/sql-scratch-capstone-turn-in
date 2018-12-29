-- Question 1
SELECT *
FROM survey
LIMIT 10;


-- Question 2
SELECT question, count(user_id)
FROM survey
GROUP BY question;


-- Question 3
SELECT question, 
	((count(user_id)/500.)* 100) as response_rate
FROM survey
GROUP BY question;

-- Question 4
SELECT *
FROM quiz
limit 5;

SELECT *
FROM home_try_on
limit 5;

SELECT *
FROM purchase
limit 5;


-- Question 5
SELECT DISTINCT quiz.user_id,
	CASE
		WHEN home_try_on.user_id IS NOT NULL THEN 'True'
  	ELSE 'False'
  END AS 'is_home_try_on',
  home_try_on.number_of_pairs AS 'pairs',
  CASE
  	WHEN purchase.user_id IS NOT NULL AND purchase.user_ID IS NOT 0 THEN 'True'
    ELSE 'False'
  END AS 'is_purchase'
FROM quiz
LEFT JOIN home_try_on
	ON quiz.user_id = home_try_on.user_id
LEFT JOIN purchase
	ON purchase.user_id = quiz.user_id
LIMIT 10;

-- Question 6
WITH analysis as (SELECT DISTINCT quiz.user_id,
	CASE
		WHEN home_try_on.user_id IS NOT NULL THEN 'True'
  	ELSE 'False'
  END AS 'is_home_try_on',
  home_try_on.number_of_pairs AS 'pairs',
  CASE
  	WHEN purchase.user_id IS NOT NULL AND purchase.user_ID IS NOT 0 THEN 'True'
    ELSE 'False'
  END AS 'is_purchase'
FROM quiz
LEFT JOIN home_try_on
	ON quiz.user_id = home_try_on.user_id
LEFT JOIN purchase
	ON purchase.user_id = quiz.user_id)
SELECT COUNT(user_id) AS 'users',
	SUM(is_home_try_on IS NOT 'False') AS 'num_try_on',
	SUM(is_purchase IS NOT 'False') as 'num_purchase',
 	1.0 * SUM(is_home_try_on IS NOT 'False') / COUNT(user_id) as 'browse_try',
 	1.0 * SUM(is_purchase IS NOT 'False') / SUM(is_home_try_on IS NOT 'False') as 'try_buy',
  	1.0 * SUM(is_purchase IS NOT 'False') / COUNT(user_id) AS 'Total_Purchase_Rate'
FROM analysis;


WITH analysis as (SELECT DISTINCT quiz.user_id,
	CASE
		WHEN home_try_on.user_id IS NOT NULL THEN 'True'
  	ELSE 'False'
  END AS 'is_home_try_on',
  home_try_on.number_of_pairs AS 'pairs',
  CASE
  	WHEN purchase.user_id IS NOT NULL AND purchase.user_ID IS NOT 0 THEN 'True'
    ELSE 'False'
  END AS 'is_purchase',
  purchase.price AS 'sales'
FROM quiz
LEFT JOIN home_try_on
	ON quiz.user_id = home_try_on.user_id
LEFT JOIN purchase
	ON purchase.user_id = quiz.user_id)
SELECT COUNT(user_id) AS 'users',
	SUM(is_home_try_on IS NOT 'False') AS 'num_try_on',
	SUM(is_purchase IS NOT 'False') as 'num_purchase',
 	1.0 * SUM(is_home_try_on IS NOT 'False') / COUNT(user_id) as 'browse_try',
 	1.0 * SUM(is_purchase IS NOT 'False') / SUM(is_home_try_on IS NOT 'False') as 'try_buy',
  	1.0 * SUM(is_purchase IS NOT 'False') / COUNT(user_id) AS 'Total_Purchase_Rate',
  SUM(sales)
FROM analysis
WHERE pairs IS '3 pairs';


WITH analysis as (SELECT DISTINCT quiz.user_id,
	CASE
		WHEN home_try_on.user_id IS NOT NULL THEN 'True'
  	ELSE 'False'
  END AS 'is_home_try_on',
  home_try_on.number_of_pairs AS 'pairs',
  CASE
  	WHEN purchase.user_id IS NOT NULL AND purchase.user_ID IS NOT 0 THEN 'True'
    ELSE 'False'
  END AS 'is_purchase',
  purchase.price AS 'sales'
FROM quiz
LEFT JOIN home_try_on
	ON quiz.user_id = home_try_on.user_id
LEFT JOIN purchase
	ON purchase.user_id = quiz.user_id)
SELECT COUNT(user_id) AS 'users',
	SUM(is_home_try_on IS NOT 'False') AS 'num_try_on',
	SUM(is_purchase IS NOT 'False') as 'num_purchase',
 	1.0 * SUM(is_home_try_on IS NOT 'False') / COUNT(user_id) as 'browse_try',
 	1.0 * SUM(is_purchase IS NOT 'False') / SUM(is_home_try_on IS NOT 'False') as 'try_buy',
  	1.0 * SUM(is_purchase IS NOT 'False') / COUNT(user_id) AS 'Total_Purchase_Rate',
  SUM(sales)
FROM analysis
WHERE pairs IS '5 pairs';


SELECT DISTINCT count(quiz.user_id) AS 'users',
	quiz.style,
  CASE
  	WHEN purchase.user_id IS NOT NULL AND purchase.user_ID IS NOT 0 THEN 'True'
    ELSE 'False'
  END AS 'is_purchase'
FROM quiz
LEFT JOIN home_try_on
	ON quiz.user_id = home_try_on.user_id
LEFT JOIN purchase
	ON purchase.user_id = quiz.user_id
WHERE is_purchase IS NOT 'False'
GROUP BY quiz.style;


SELECT DISTINCT count(quiz.user_id) AS 'users',
	purchase.color,
  CASE
  	WHEN purchase.user_id IS NOT NULL AND purchase.user_ID IS NOT 0 THEN 'True'
    ELSE 'False'
  END AS 'is_purchase'
FROM quiz
LEFT JOIN home_try_on
	ON quiz.user_id = home_try_on.user_id
LEFT JOIN purchase
	ON purchase.user_id = quiz.user_id
WHERE is_purchase IS NOT 'False'
GROUP BY purchase.color
ORDER BY users DESC;

