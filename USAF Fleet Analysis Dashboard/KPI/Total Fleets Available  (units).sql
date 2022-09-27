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
          10)),
      t2 (mission_id, mission_name, total_distance, mission_start, mission_end, create_dat, updated_at, status_mission, depots, aoc, fleet)
      AS (
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
    model,
    milage
  FROM
    "icebase"."mitreusaf".usaf_fleet where cast(milage as double)  > 0
),
t3 AS (
  SELECT
    count(DISTINCT fleet) AS total_mission_fleet,
    count(DISTINCT icao24) AS total_fleet
FROM
  t1
    RIGHT JOIN t2 ON t1.fleet = t2.icao24
)
SELECT
  total_fleet - total_mission_fleet AS total_fleet_available
FROM
  t3