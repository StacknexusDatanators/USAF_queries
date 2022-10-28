SELECT p.v2productcategory AS "Product Category",
       TYPE,
       count(r.productsku) AS product_purchase
FROM icebase.merchandise_retail.retail_transactions AS r
JOIN icebase.merchandise_retail.retail_product AS p ON p.productsku = r.productsku
WHERE TYPE = '{{ pruchase type }}'
  AND p.v2productcategory <> '(not set)'
GROUP BY p.v2productcategory,
         TYPE
ORDER BY product_purchase DESC
LIMIT 5