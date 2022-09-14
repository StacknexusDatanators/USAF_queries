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
)
  SELECT DISTINCT
    missionname,
    date_diff ('day', start_date, end_date) AS Days
FROM
  t1
 WHERE date_diff ('day', start_date, end_date)>0
ORDER BY
  2 ASC