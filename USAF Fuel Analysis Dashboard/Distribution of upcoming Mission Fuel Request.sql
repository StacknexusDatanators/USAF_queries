WITH t1 AS (
  SELECT
    missionname,
    missionid
  FROM
    "icebase"."mitreusaf".usaf_mission
  WHERE
    start_date >= CURRENT_DATE
),
t2 AS (
  SELECT
    missionid,
    fuelval
  FROM
    "icebase"."mitreusaf".usaf_fuel_requests
)
SELECT
  missionname,
  count(fuelval) AS total_fuel_reserved
FROM
  t1
  JOIN t2 ON t1.missionid = t2.missionid
GROUP BY
  1
ORDER BY
  2 DESC