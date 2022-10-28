SELECT MONTH,
       total_sales,
       no_of_month
FROM
  (SELECT week_of_year(TIME) AS MONTH,
          month(TIME) AS no_of_month,
          cast(year(TIME) AS varchar) AS YEAR,
          sum(productprice * quantity) AS total_sales
   FROM "icebase"."merchandise_retail".retail_transaction
   WHERE year(TIME) = {{ YEAR }}
   GROUP BY 1,
            2,
            3
   ORDER BY 2)
ORDER BY 1