SELECT
  format_number (total_reordered) as total_reordered
FROM (
  SELECT
    count_if(reordered = 1)  AS total_reordered
  FROM
    "icebase"."retail_store".order_products)