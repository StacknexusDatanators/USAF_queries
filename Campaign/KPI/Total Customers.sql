SELECT
count(distinct customer.customer_index) as total_customer
FROM (
  SELECT
    order_id,
    sku_id,
    customer_index
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
  JOIN (
    SELECT
      customer_index
    FROM
      icebase.campaign.customers) as customer
    ON transaction.customer_index = customer.customer_index