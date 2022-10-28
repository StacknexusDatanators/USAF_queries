WITH customer AS
  (SELECT id,
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
   FROM "icebase"."merchandise_retail".retail_customer),
     TRANSACTION AS
  (SELECT customer_id,
          productsku,
          quantity,
          TYPE,
          productprice,
          TIME
   FROM "icebase"."merchandise_retail".retail_transaction
   WHERE TYPE = 'refund' ), cust_transaction AS
  (SELECT *
   FROM TRANSACTION
   JOIN customer ON transaction.customer_id = customer.id),
                            product AS
  (SELECT productsku AS product_id,
          v2productname,
          productbrand,
          productrevenue
   FROM "icebase"."merchandise_retail".retail_product),
                            FINAL AS
  (SELECT *
   FROM cust_transaction
   JOIN product ON cust_transaction.productsku = product.product_id)
SELECT v2productname,
       sum(productprice*quantity) AS toatl_revenue
FROM FINAL
WHERE year(TIME) = {{ YEAR }}
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10