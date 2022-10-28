SELECT
  order_hour_of_day AS "Hour",
  count(DISTINCT order_id) AS "Total Orders"
FROM (
  SELECT
    *
  FROM
    icebase.retail_store.orders
  ORDER BY
    order_id)
GROUP BY
  order_hour_of_day
ORDER BY
  order_hour_of_day