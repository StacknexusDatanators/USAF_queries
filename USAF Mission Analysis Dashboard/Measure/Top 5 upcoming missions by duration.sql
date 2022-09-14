SELECT
  missionname,date_diff ('day', start_date, end_date) AS days
FROM
  icebase.mitreusaf.usaf_mission
where start_date >= current_timestamp(6)
order by 2 desc
limit 5