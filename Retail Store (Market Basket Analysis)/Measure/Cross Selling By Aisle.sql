WITH t1 AS (
  SELECT
    order_id,
    aisle
  FROM (
    SELECT
      *
    FROM
      icebase.retail_store.order_products
    ORDER BY
      order_id)
    LEFT JOIN icebase.retail_store.products USING (product_id)
    LEFT JOIN icebase.retail_store.aisles USING (aisle_id)
  WHERE
    department_id != 1
)
SELECT
  fp AS e1,
  sp AS e2,
  TO AS value
FROM (
  SELECT
    a.aisle AS fp,
    b.aisle AS sp,
    count(*) AS to
  FROM
    t1 AS a,
    t1 AS b
  WHERE
    a.order_id = b.order_id
    AND a.aisle != b.aisle
    AND a.aisle < b.aisle
  GROUP BY
    1,
    2)
WHERE
  TO >= 100
ORDER BY
  3 DESC
LIMIT 20