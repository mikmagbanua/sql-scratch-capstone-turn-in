SELECT style, COUNT(DISTINCT user_id) AS 'Count'
FROM quiz
GROUP BY 1
ORDER BY 2 DESC;

SELECT model_name, COUNT(DISTINCT user_id) AS 'Count'
FROM purchase
GROUP BY 1
ORDER BY 2 DESC;

SELECT question, COUNT(DISTINCT user_id) AS 'Count'
FROM survey
GROUP BY 1;

WITH funnel AS (
  SELECT DISTINCT q.user_id,
  h.user_id IS NOT NULL AS 'is_home_try_on',
  h.number_of_pairs,
  p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz AS q
LEFT JOIN home_try_on AS h
	ON q.user_id = h.user_id
LEFT JOIN purchase AS p
	ON p.user_id = q.user_id)
SELECT number_of_pairs,
SUM(is_purchase) AS 'num_purchase'
FROM funnel
WHERE number_of_pairs IS NOT NULL
GROUP BY 1;

