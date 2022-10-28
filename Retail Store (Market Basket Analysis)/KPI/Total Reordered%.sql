SELECT
  (100 * ro) / TO AS "Reordered %"
FROM (
  SELECT
    count(order_id) AS o,
    sum(TO) AS to,
    sum(ro) AS ro
  FROM (
    SELECT
      order_id,
      count(DISTINCT product_id) AS to,
      count(DISTINCT product_id) FILTER (WHERE reordered = 1) AS ro
    FROM (
      SELECT
        *
      FROM
        icebase.retail_store.order_products
      ORDER BY
        order_id)
    GROUP BY
      1))