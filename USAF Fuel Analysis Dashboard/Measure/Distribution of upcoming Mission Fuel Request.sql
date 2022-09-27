WITH t1 AS (
  SELECT
    mission_name,
    mission_id
  FROM
    "missionusafdbdatabase"."public".missiondata
  WHERE
    mission_start >= CURRENT_DATE
),
t2 AS (
  SELECT
    missionid,
    fuelval
  FROM
    "icebase"."mitreusaf".usaf_fuel_requests
)
SELECT
  mission_name,
  count(fuelval) AS total_fuel_reserved
FROM
  t1
  JOIN t2 ON t1.mission_id = t2.missionid
GROUP BY
  1
ORDER BY
  2 DESC