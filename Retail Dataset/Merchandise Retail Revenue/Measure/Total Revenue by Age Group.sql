SELECT AgeGroups,
       sum(Product_Price) AS Total_Revenue
FROM
  (SELECT CASE
              WHEN cast(c.age AS int) <18 THEN 'Under 18'
              WHEN cast(c.age AS int) BETWEEN 18 AND 24 THEN '18-24'
              WHEN cast(c.age AS int) BETWEEN 25 AND 34 THEN '25-34'
              WHEN cast(c.age AS int) BETWEEN 35 AND 44 THEN '35-44'
              WHEN cast(c.age AS int) BETWEEN 45 AND 54 THEN '45-54'
              WHEN cast(c.age AS int) BETWEEN 55 AND 64 THEN '55-64'
              ELSE '60+'
          END AS AgeGroups,
          (cast(t.quantity AS int)*cast(t.productprice AS int)) AS Product_Price
   FROM icebase.merchandise_retail.retail_customer AS c
   JOIN icebase.merchandise_retail.retail_transactions AS t ON t.customer_id=c.id)
GROUP BY AgeGroups
ORDER BY AgeGroups ASC