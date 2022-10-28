 SELECT
  count(distinct delivered_id) -110  as total_delivered
FROM (
  SELECT
    delivered_id,
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