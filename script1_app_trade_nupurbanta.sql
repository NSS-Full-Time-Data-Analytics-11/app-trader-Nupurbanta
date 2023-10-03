--
SELECT *
FROM app_store_apps
WHERE rating >= 4.0
ORDER BY rating DESC ;

SELECT *
FROM play_store_apps
WHERE rating >= 4.0
ORDER BY rating DESC;
--general recommendations
SELECT DISTINCT *
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
USING (name)
WHERE a.rating >= 4.0
AND p.rating >= 4.0 ;
--Top 10 List of the apps that are based on return on investment 
WITH both_rating AS (SELECT DISTINCT name, ROUND((a.rating + p.rating)/2, 2) AS avg_rating
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
USING(name)),
both_cost AS (SELECT DISTINCT name, (a.price::money + p.price::Money)/2 AS avg_price
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
USING (name))
SELECT both_rating.name, both_rating.avg_rating, both_cost.avg_price
FROM both_rating
INNER JOIN both_cost
USING(name)
WHERE both_rating.avg_rating >= 4.0
AND both_cost.avg_price BETWEEN '$0.00' AND '$2.50'
ORDER BY both_rating.avg_rating DESC
LIMIT 10;

--Top 5 list of profitable 
WITH both_rating AS (SELECT DISTINCT name, ROUND((a.rating + p.rating)/2, 2) AS avg_rating
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
USING(name)),
both_cost AS (SELECT DISTINCT name, (a.price::money + p.price::Money)/2 AS avg_price
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
USING (name))
SELECT both_rating.name, both_rating.avg_rating, both_cost.avg_price
FROM both_rating
INNER JOIN both_cost
USING(name)
WHERE both_rating.name ILIKE '%chick%'
OR both_rating.name ILIKE '%halloween%'
OR both_rating.name ILIKE '%zombie%'
ORDER BY both_rating.avg_rating DESC ;