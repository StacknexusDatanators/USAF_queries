SELECT
  count(DISTINCT OWNER) AS total_owner
FROM
  "icebase"."mitreusaf".usaf_fleet
WHERE
  cast(milage AS double) > 0