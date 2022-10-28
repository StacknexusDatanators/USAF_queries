SELECT count(t.productsku) AS count_of_product,
       v2productcategory AS "Product Category"
FROM icebase.merchandise_retail.retail_transactions AS t
JOIN icebase.merchandise_retail.retail_product AS p ON p.productsku = t.productsku
GROUP BY v2productcategory
ORDER BY count_of_product DESC
LIMIT 5