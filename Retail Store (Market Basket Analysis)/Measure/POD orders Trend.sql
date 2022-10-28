SELECT
  CASE WHEN hour >= 5
    AND hour <= 12 THEN
    'Morning'
  WHEN hour > 12
    AND hour <= 17 THEN
    'Afternoon'
  WHEN hour > 18
    AND hour <= 21 THEN
    'Evening'
  ELSE
    'Night'
  END AS "Hour",
  count(DISTINCT order_id) AS "Total Order"
FROM (
  SELECT
    order_hour_of_day as hour,
    order_id
  FROM (
    SELECT
      *
    FROM
      icebase.retail_store.orders
    ORDER BY
      order_id))
GROUP BY
  1
ORDER BY
  2 DESC