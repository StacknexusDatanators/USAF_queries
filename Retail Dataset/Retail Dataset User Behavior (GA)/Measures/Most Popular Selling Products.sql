SELECT p.v2ProductName AS "Product Name",
       count(h.item.transactionId) AS Number_Of_Sales
FROM icebase.merchandise_retail.ga_session_dataset,
     unnest(hits) AS h,
     unnest(h.product) AS p
GROUP BY p.v2ProductName
ORDER BY count(h.item.transactionId) DESC
LIMIT 10