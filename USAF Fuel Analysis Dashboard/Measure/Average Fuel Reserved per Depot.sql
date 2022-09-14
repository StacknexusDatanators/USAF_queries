WITH t1 AS (
  SELECT
    depotid,
    depotname
  FROM
    "icebase"."mitreusaf".usaf_depot
),
t2 AS (
  SELECT
    depotid,
    fuelval
  FROM
    "icebase"."mitreusaf".usaf_fuel_requests
)
SELECT
  depotname,
  count(fuelval) AS total_fuel_reserved
FROM
  t1
  JOIN t2 ON t1.depotid = t2.depotid
GROUP BY
  1
ORDER BY
  2 DESC