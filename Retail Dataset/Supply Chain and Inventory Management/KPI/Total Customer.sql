WITH customer AS (
  SELECT
    customer_index,
    id,
    gender,
    age,
    education_level,
    marital_status,
    occupation,
    employment_status,
    degree_of_loyalty,
    user_status,
    social_class,
    lifestyle
  FROM
    "icebase"."merchandise_retail".retail_customer
),
TRANSACTION AS (
  SELECT
    customer_id,
    productsku,
    quantity,
    type,
    productprice,
    time
  FROM
    "icebase"."merchandise_retail".retail_transaction
  WHERE
    type = 'purchase'
),
cust_transaction AS (
  SELECT
    *
  FROM
    TRANSACTION
    JOIN customer ON transaction.customer_id = customer.id
),
product AS (
  SELECT
    productsku as product_id,
    v2productname,
    productbrand,
  
    productrevenue
  FROM
    "icebase"."merchandise_retail".retail_product
),
final AS (
  SELECT
    *
  FROM
    cust_transaction
    JOIN product ON cust_transaction.productsku = product.product_id
)
SELECT
format_number(count(id))  as toatl_customer
FROM
  final
where year(time ) = {{ year }}
LIMIT 10