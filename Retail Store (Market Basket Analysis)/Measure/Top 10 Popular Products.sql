WITH t1 AS (
  SELECT
    *
  FROM (
    SELECT
      product_name,
      count(DISTINCT order_id) AS TO
  FROM (
    SELECT
      *
    FROM
      icebase.retail_store.order_products
    ORDER BY
      order_id)
    LEFT JOIN icebase.retail_store.products USING (product_id)
  WHERE
    department_id != 21
  GROUP BY
    product_name)
  WHERE
    TO > 100
)
SELECT
  product_name AS "Product Name",
  TO AS "Total Orders"
FROM
  t1 AS p
ORDER BY
  2 DESC
LIMIT 10