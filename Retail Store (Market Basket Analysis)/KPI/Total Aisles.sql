SELECT
  count(DISTINCT aisle_id) AS "Total Aisles"
FROM (
  SELECT
    aisle_id,
    product_id,
    count(DISTINCT order_id) AS to
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
  1, 2)
WHERE
  TO >= 10