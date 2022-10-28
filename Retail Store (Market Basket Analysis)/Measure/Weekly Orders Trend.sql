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
    END) AS "Day",count(distinct order_id) AS "Total Orders"
FROM (
  SELECT
    *
  FROM
    icebase.retail_store.orders order by order_id )

GROUP BY
  order_dow
ORDER BY
  order_dow