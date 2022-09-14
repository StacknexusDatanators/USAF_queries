SELECT
  aoc.name,
  count(missionid) as count_of_missions
FROM
  "icebase"."mitreusaf".usaf_mission mis
  LEFT JOIN "icebase"."mitreusaf".usaf_aoc aoc ON mis.aoc = aoc.idaoc
GROUP BY
  1