WITH t1 AS (
  WITH t1 AS (
    SELECT
      missionid,
      missionname,
      total_distance,
      start_date,
      end_date,
      createdat,
      updatedat,
      status,
      depots,
      aoc,
      split (fleets, ',') AS fleet_id
    FROM (
      SELECT
        missionname,
        missionid,
        total_distance,
        start_date,
        end_date,
        createdat,
        updatedat,
        status,
        depots,
        aoc,
        listagg (fleet, ',') WITHIN GROUP (ORDER BY missionid) AS fleets
      FROM
        "icebase"."mitreusaf".usaf_mission GROUP BY
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
      t2 (missionid, missionname, total_distance, start_date, end_date, createdat, updatedat, status, depots, aoc, fleet)
      AS (
      SELECT
        missionid,
        missionname,
        total_distance,
        start_date,
        end_date,
        createdat,
        updatedat,
        status,
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
    missionname,
    
    sum(round(cast(milage AS double), 2)) AS total_mileage
FROM
  t1
  JOIN t2 ON t1.fleet = t2.icao24
  group by 1
) select * from t3 order by 2 desc
