SELECT concat(MONTH, '-', YEAR) AS month_of_year,
       count_of_oders,
       no_of_month
FROM
  (SELECT date_format (TIME, '%b') AS MONTH,
          month(TIME) AS no_of_month,
          cast(year(TIME) AS varchar) AS YEAR,
          count(productsku) AS count_of_oders
   FROM "icebase"."merchandise_retail".retail_transaction
   WHERE year(TIME) IN ({{ YEAR }})
   GROUP BY 1,
            2,
            3
   ORDER BY 2)
ORDER BY 3