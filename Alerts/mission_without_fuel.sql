SELECT DISTINCT
  t1.missionid,
  date_add ('day', 1, date(start_date)) sd,
  CURRENT_DATE AS cd
FROM
  icebase.mitreusaf.usaf_mission t1
  LEFT OUTER JOIN icebase.mitreusaf.usaf_fuel_requests t2 ON t1.missionid = t2.missionid
WHERE
  t2.fuelval IS NULL