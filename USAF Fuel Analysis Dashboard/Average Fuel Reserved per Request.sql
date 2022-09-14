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
  round(total_fuel_request / total_fuel_reserved, 2) AS avg_fuel_reservered_per_request
FROM (
  SELECT
    sum(fuelval) AS total_fuel_request,
    count(fuelval) AS total_fuel_reserved
  FROM
    t1
    JOIN t2 ON t1.depotid = t2.depotid)