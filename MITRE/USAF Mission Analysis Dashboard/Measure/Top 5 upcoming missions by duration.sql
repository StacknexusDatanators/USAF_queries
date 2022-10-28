SELECT
  mission_name,date_diff ('day', mission_start, mission_end) AS days
FROM
  "missionusafdbdatabase"."public".missiondata
where mission_start >= current_timestamp(6)
order by 2 desc
limit 5