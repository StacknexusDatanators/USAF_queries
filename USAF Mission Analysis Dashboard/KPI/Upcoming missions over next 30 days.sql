SELECT
  count(DISTINCT missionid) as count_of_missions_next_30_days
FROM
  "icebase"."mitreusaf".usaf_mission
where start_date > current_timestamp(6)
or date_diff('day',start_date,current_timestamp(6)) <=30