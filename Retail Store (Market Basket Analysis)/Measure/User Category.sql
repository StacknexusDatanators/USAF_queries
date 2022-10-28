SELECT
  CASE WHEN cc IS NULL THEN
    'Total'
  ELSE
    cc
  END AS "Customers Categories",
  u AS "Total Customers"
FROM (
  SELECT
    cc,
    count(DISTINCT user_id) AS u
  FROM (
    SELECT
      user_id,
      rfm_combined,
      CASE WHEN rfm_combined = 333 THEN
        'Champion Customers'
      WHEN rfm_combined < 333
        AND rfm_combined >= 311 THEN
        'Loyal Customers'
      WHEN rfm_combined < 311
        AND rfm_combined >= 211 THEN
        'Potential Customers'
      WHEN rfm_combined = 111 THEN
        'Lost Customers'
      ELSE
        'Hibernating Customers'
      END AS cc
    FROM (
      SELECT
        user_id,
        rfm_recency * 100 + rfm_frequency * 10 + rfm_monetary AS rfm_combined
      FROM (
        SELECT
          user_id,
          recency,
          frequency,
          monetry,
          ntile(3) OVER (ORDER BY recency) AS rfm_recency,
          ntile(3) OVER (ORDER BY frequency) AS rfm_frequency,
          ntile(3) OVER (ORDER BY monetry) AS rfm_monetary
        FROM (
          SELECT
            user_id,
            min(last_order_day) AS recency,
            sum(count_order) AS frequency,
            sum(count_reordered) AS monetry
          FROM (
            SELECT
              user_id,
              count(DISTINCT product_id) AS count_order,
              min(days_since_prior_order) AS last_order_day,
              count(DISTINCT product_id) FILTER (WHERE reordered = 1) AS count_reordered
            FROM (
              SELECT
                user_id,
                a.order_id,
                a.product_id,
                a.reordered,
                 b.days_since_prior_order
              FROM
                icebase.retail_store.order_products a
              join icebase.retail_store.orders b
              on a.order_id = b.order_id
)
          GROUP BY
            user_id
          ORDER BY
            3 DESC)
        GROUP BY
          1
        ORDER BY
          3 DESC))))
GROUP BY
  ROLLUP (cc)
ORDER BY
  2 DESC)
ORDER BY
  2 DESC