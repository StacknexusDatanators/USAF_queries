SELECT count(DISTINCT productbrand) AS total_brand
FROM "icebase"."merchandise_retail".retail_product
LIMIT 10