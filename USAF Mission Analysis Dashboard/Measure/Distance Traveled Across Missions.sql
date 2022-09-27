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
)
  SELECT DISTINCT
    mission_name,
    total_distance
  FROM
    t1
  ORDER BY
    2 DESC