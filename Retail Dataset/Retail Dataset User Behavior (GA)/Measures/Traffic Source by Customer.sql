SELECT trafficSource.medium AS Traffic_Medium,
       trafficSource.source AS Traffic_Source,
       count(fullVisitorId) AS Number_Of_Visitor
FROM icebase.merchandise_retail.ga_session_dataset
WHERE geoNetwork.country IN ({{ Country }})
GROUP BY trafficSource.medium,
         trafficSource.source
ORDER BY count(fullVisitorId) DESC
LIMIT 5