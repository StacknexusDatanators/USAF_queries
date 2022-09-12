--Total Fuel Stations--
    WITH t1 AS (
    SELECT
      idaoc,
      name,
      description,
      city,
      country,
      split (depots, ',') AS depots
  FROM (
    SELECT
      idaoc,
      name,
      description,
      city,
      country,
      listagg (depots, ',') WITHIN GROUP (ORDER BY idaoc) AS depots
  FROM
    "icebase"."mitreusaf".usaf_aoc GROUP BY
      1,
      2,
      3,
      4,
      5)),
  t2 (idaoc, name, description, city, country, depot_id)
AS (
SELECT
  idaoc,
  name,
  description,
  city,
  country,
  t.*
FROM
  t1
    CROSS JOIN unnest(depots) AS t
)
    SELECT
      count(distinct depot_id) as total_depot
    FROM
      T2
