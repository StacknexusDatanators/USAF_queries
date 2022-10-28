WITH a AS (
  SELECT
    *
  FROM (
    SELECT
      *
    FROM
      icebase.retail_store.orders
    ORDER BY
      order_id
   ))
SELECT
  (
    CASE WHEN order_dow = 0 THEN
      'Sunday'
    WHEN order_dow = 1 THEN
      'Monday'
    WHEN order_dow = 2 THEN
      'Tuesday'
    WHEN order_dow = 3 THEN
      'Wednesday'
    WHEN order_dow = 4 THEN
      'Thursday'
    WHEN order_dow = 5 THEN
      'Friday'
    WHEN order_dow = 6 THEN
      'Saturday'
    END) AS "Day",
  order_hour_of_day AS "Hour",
  count(DISTINCT order_id) AS "Total Orders"
FROM
  a
GROUP BY
  order_dow,
  order_hour_of_day
ORDER BY
  order_dow,
  order_hour_of_day