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
  sum(fuelval) AS total_fuel_reserved
FROM
  t1
  JOIN t2 ON t1.depotid = t2.depotid
group by 1
order by 2 desc