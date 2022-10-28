SELECT num_transactions, date
FROM
  (SELECT count(DISTINCT customer_id) AS num_transactions,
          date(TIME) AS date
   FROM icebase.merchandise_retail.retail_transaction
   WHERE YEAR (TIME) = {{ YEAR }}
   GROUP BY date(TIME))