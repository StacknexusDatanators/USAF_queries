SELECT
  round(avg(tc), 2) AS avg_order
FROM (
  SELECT
    user_id,
    count(DISTINCT order_id) AS tc
  FROM (
    SELECT
      *
    FROM
      icebase.retail_store.orders)
  GROUP BY
    1)