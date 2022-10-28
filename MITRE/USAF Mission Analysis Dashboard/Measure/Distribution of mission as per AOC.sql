SELECT
  aoc.name,
  count(mission_id) as count_of_missions
FROM
  "missionusafdbdatabase"."public".missiondata mis
  LEFT JOIN "icebase"."mitreusaf".usaf_aoc aoc ON mis.aoc = aoc.idaoc
GROUP BY
  1