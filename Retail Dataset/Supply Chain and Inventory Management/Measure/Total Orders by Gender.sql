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
   FROM "icebase"."merchandise_retail".retail_transaction), FINAL AS
  (SELECT *
   FROM TRANSACTION
   JOIN customer ON transaction.customer_id = customer.id)
SELECT gender,
       TYPE,
       count(productsku) AS count_of_product
FROM FINAL
WHERE year(TIME) = {{ YEAR }}
GROUP BY 1,
         2
ORDER BY 3 DESC
LIMIT 100