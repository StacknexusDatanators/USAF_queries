SELECT
  order_hour_of_day,
  cc,
  count(DISTINCT user_id)
FROM (
  SELECT
    order_hour_of_day,
    user_id,
    recency,
    frequency,
    monetry,
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
      order_hour_of_day,
      user_id,
      recency,
      frequency,
      monetry,
      rfm_recency * 100 + rfm_frequency * 10 + rfm_monetary AS rfm_combined
    FROM (
      SELECT
        order_hour_of_day,
        user_id,
        recency,
        frequency,
        monetry,
        ntile(3) OVER (ORDER BY recency) AS rfm_recency,
        ntile(3) OVER (ORDER BY frequency) AS rfm_frequency,
        ntile(3) OVER (ORDER BY monetry) AS rfm_monetary
      FROM (
        SELECT
          order_hour_of_day,
          user_id,
          min(last_order_day) AS recency,
          sum(count_order) AS frequency,
          sum(count_reordered) AS monetry
        FROM (
          SELECT
            order_hour_of_day,
            user_id,
            count(DISTINCT product_id) AS count_order,
            min(days_since_prior_order) AS last_order_day,
            count(DISTINCT product_id) FILTER (WHERE reordered = 1) AS count_reordered
          FROM (
            SELECT
              order_hour_of_day,
              user_id,
              a.order_id,
              product_id,
              reordered,
              b.days_since_prior_order
            FROM
              icebase.retail_store.order_products a
              JOIN icebase.retail_store.orders b ON a.order_id = b.order_id)
          GROUP BY
            order_hour_of_day,
            user_id
          ORDER BY
            3 DESC)
        GROUP BY
          1,
          2
        ORDER BY
          3 DESC))))
GROUP BY
  1,
  2
ORDER BY
  1