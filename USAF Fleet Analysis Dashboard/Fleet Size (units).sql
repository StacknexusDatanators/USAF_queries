SELECT
  count(DISTINCT model) AS total_model
FROM
  "icebase"."mitreusaf".usaf_fleet
WHERE
  cast(milage AS double) > 0