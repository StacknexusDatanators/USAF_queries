SELECT
  format_number (total_orders) AS total_orders
FROM (
  SELECT
    count(DISTINCT order_id) AS total_orders
  FROM
    "icebase"."retail_store".orders)