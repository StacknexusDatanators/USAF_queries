SELECT
  owner,
  count( icao24) AS total_fleet
FROM
  "icebase"."mitreusaf".usaf_fleet
WHERE
  cast(milage AS double) > 0
group by 1 
order by 2 desc  limit 5