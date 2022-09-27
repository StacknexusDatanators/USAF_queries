WITH t1 AS (
WITH t1 AS (
  SELECT
    mission_id,
    mission_name,
    total_distance,
    mission_start,
    mission_end,
    created_at,
    updated_at,
    status_mission,
    depots,
    aoc,
    split (fleets, ',') AS fleet_id
  FROM (
    SELECT
      mission_name,
      mission_id,
      total_distance,
      mission_start,
      mission_end,
      created_at,
      updated_at,
      status_mission,
      depots,
      aoc,
      listagg (fleet, ',') WITHIN GROUP (ORDER BY mission_id) AS fleets
    FROM
      "missionusafdbdatabase"."public".missiondata GROUP BY
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10)
),
t2 (
  mission_id, mission_name, total_distance, mission_start, mission_end, created_at, updated_at, status_mission, depots, aoc, fleet
) AS (
  SELECT
    mission_id,
    mission_name,
    total_distance,
    mission_start,
    mission_end,
    created_at,
    updated_at,
    status_mission,
    depots,
    aoc,
    t.*
  FROM
    t1
    CROSS JOIN unnest(fleet_id) AS t
)
      SELECT
        *
      FROM
        t2
),
t2 AS (
  SELECT
    icao24,
    manufacturername,
    model,
    OPERATOR,
    OWNER,
    milage
  FROM
    "icebase"."mitreusaf".usaf_fleet
),
t3 AS (
  SELECT
    model,
    sum(round(cast(milage AS double), 2)) AS total_mileage
  FROM
    t1
    JOIN t2 ON t1.fleet = t2.icao24 GROUP BY
      1
)
  SELECT
    *
  FROM
    t3
  ORDER BY
    2 DESC