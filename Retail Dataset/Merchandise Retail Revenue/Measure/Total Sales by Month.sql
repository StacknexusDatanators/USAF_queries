SELECT round(avg(CAST(quantity AS bigint) * CAST(productprice AS bigint)), 2) AS avg_total_price,
       date(TIME) AS dates
FROM icebase.merchandise_retail.retail_transaction
WHERE year(TIME) = {{ YEAR }}
GROUP BY 2
ORDER BY 2