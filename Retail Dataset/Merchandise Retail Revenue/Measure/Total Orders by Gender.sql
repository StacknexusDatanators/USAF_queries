SELECT count(DISTINCT customer_id) AS num_transactions,
       gender
FROM icebase.merchandise_retail.retail_transactions t1
LEFT JOIN icebase.merchandise_retail.retail_customer t2 ON t1.customer_id = t2.id
GROUP BY gender