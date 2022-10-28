WITH T2 AS (
  WITH T1 AS (
    SELECT
      m1.mission_id,
      m1.mission_name,
      m1.mission_start,
      m1.total_distance,
      f1.depotid,
      f1.fuelval,
      max(f1.reservedon) UpdatedOn
    FROM
      missionusafdbdatabase.public.missiondata m1
      JOIN icebase.mitreusaf.usaf_fuel_requests F1 ON m1.mission_id = f1.missionid
    GROUP BY
      1,
      2,
      3,
      4,
      5,
      6
)
    SELECT
      d1.depotname,
      d1.currentinventory,
      sum(fuelval) FuelReq,
      max(UpdatedOn) UpdatedOn,
      min(date_add ('day', -7, date(mission_start))) Before_7_Day,
      CURRENT_DATE CurrentDate
    FROM
      T1
      JOIN icebase.mitreusaf.usaf_depot d1 ON T1.depotid = d1.depotid
    GROUP BY
      1,
      2
    ORDER BY
      5
)
  SELECT
    depotname,
    currentinventory,
    FuelReq,
    Before_7_Day,
    CurrentDate
  FROM
    t2
  WHERE
    FuelReq < currentinventory and depotname='Guam USAF Base'