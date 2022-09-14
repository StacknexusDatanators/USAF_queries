SELECT
  count(DISTINCT icao24) AS total_fleets
FROM
  "icebase"."mitreusaf".usaf_fleet
WHERE
  cast(milage AS double) > 0