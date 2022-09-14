SELECT
  manufacturername,
  count(DISTINCT icao24)
FROM
  "icebase"."mitreusaf".usaf_fleet
GROUP BY
  1
ORDER BY
  2 DESC
LIMIT 10
