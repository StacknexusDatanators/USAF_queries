SELECT
  format_number (total_product) AS total_product
FROM (
  SELECT
    count(DISTINCT product_id) AS total_product
  FROM
    "icebase"."retail_store".order_products)