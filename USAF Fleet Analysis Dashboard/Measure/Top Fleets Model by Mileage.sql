SELECT DISTINCT
  model,
  round(cast(milage AS double), 2) AS milage
FROM
  "icebase"."mitreusaf".usaf_fleet
WHERE
  cast(milage AS double) > 0 and owner = '{{ owner }}'
ORDER BY
  2 DESC
LIMIT 10