SELECT count(distinct model) as total_model FROM "icebase"."mitreusaf".usaf_fleet where cast(milage as double)  > 0