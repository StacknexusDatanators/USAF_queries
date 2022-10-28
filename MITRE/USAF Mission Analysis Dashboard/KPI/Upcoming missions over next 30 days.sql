SELECT
  count(DISTINCT mission_id) as count_of_missions_next_30_days
FROM
  "missionusafdbdatabase"."public".missiondata
where mission_start > current_timestamp(6)
or date_diff('day',mission_start,current_timestamp(6)) <=30