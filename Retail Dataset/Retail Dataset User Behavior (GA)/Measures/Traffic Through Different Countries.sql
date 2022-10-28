SELECT geoNetwork.country AS Country,
       count(fullVisitorId) AS "Number Of Visitors"
FROM icebase.merchandise_retail.ga_session_dataset
GROUP BY geoNetwork.country
ORDER BY count(fullVisitorId) DESC
LIMIT 5