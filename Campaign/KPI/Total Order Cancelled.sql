SELECT
  count(distinct cancelled_id)  as total_cancelled
FROM (
  SELECT
    cancelled_id,
    sku_id
  FROM
    "icebase"."campaign".transactions
  WHERE
    campaign_id = 'camp-1') AS TRANSACTION
  JOIN (
    SELECT
      brand_name,
      product_id,
      category_name
    FROM
      "icebase"."campaign".product
    WHERE
      category_name = 'Mens T-Shirts & Tank Tops') AS product ON transaction.sku_id = product.product_id
LIMIT 10