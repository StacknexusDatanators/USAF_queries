SELECT TYPE,
       count(*) AS count_of_type
FROM "icebase"."merchandise_retail".retail_transaction
WHERE year(TIME) = {{ YEAR }}
GROUP BY 1
ORDER BY 2 DESC