WITH t1 AS (
  SELECT
    *
  FROM
    icebase.retail_store.order_products
  ORDER BY
    order_id
),
t2 AS (
  SELECT
    c.first_column,
    c.second_column
  FROM (
    SELECT
      a.product_id AS first_column,
      b.product_id AS second_column
    FROM
      t1 AS a
      INNER JOIN t1 AS b ON a.order_id = b.order_id
    WHERE
      a.product_id < b.product_id) AS c
),
t3 AS (
  SELECT
    b.product_name AS a1,
    c.product_name AS a2
  FROM
    t2
    JOIN icebase.retail_store.products AS b ON t2.first_column = b.product_id
    JOIN (
      SELECT
        product_id,
        CASE WHEN product_name LIKE '%Banana%' THEN
          'Banana'
        ELSE
          product_name
        END AS product_name,
        aisle_id,
        department_id
      FROM
        icebase.retail_store.products) AS c ON t2.second_column = c.product_id
)
SELECT
  a1 AS "First Product",
  a2 AS "Second Product",
  count(*) AS "Total Orders"
FROM
  t3
GROUP BY
  1,
  2
ORDER BY
  3 DESC
limit 100