SELECT p.v2ProductCategory AS Product_Category,
       sum(totals.bounces) AS Bounce
FROM icebase.merchandise_retail.ga_session_dataset,
     unnest(hits) AS h,
     unnest(h.product) AS p
WHERE p.v2ProductCategory!='(not set)'
GROUP BY p.v2ProductCategory
ORDER BY sum(totals.bounces) DESC
LIMIT 5