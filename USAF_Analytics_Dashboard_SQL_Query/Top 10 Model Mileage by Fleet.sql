SELECT
  distinct 
  model,
  round(cast(milage AS double),2) as milage
FROM
  "icebase"."mitreusaf".usaf_fleet
WHERE
  cast(milage AS double) > 0
order by 2 desc 
limit 10
