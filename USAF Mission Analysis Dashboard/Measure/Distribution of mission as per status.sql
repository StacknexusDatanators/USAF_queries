WITH t3 as(
WITH t2 as(
WITH t1 as (select um.missionid as missionid,sum(cast (uf.milage as double)) as total_mileage
from icebase.mitreusaf.usaf_fleet uf
left join
icebase.mitreusaf.usaf_mission um
CROSS JOIN UNNEST(SPLIT(fleet,',')) AS t (fleet_id)
on fleet_id = uf.icao24
group by 1
)
select t1.missionid as missionid, round((t1.total_mileage*um.total_distance),2) as fuel_requirement
from
icebase.mitreusaf.usaf_mission um
left join t1
on um.missionid = t1.missionid
)
SELECT t2.missionid,t2.fuel_requirement, sum(ufr.fuelval) as total_fuel_procured
FROM
  t2
  left join
  "icebase"."mitreusaf".usaf_fuel_requests ufr
  on t2.missionid = ufr.missionid
  group by 1,2
)
select count(t3.missionid) as count_of_missions,
  (case when (t3.fuel_requirement > t3.total_fuel_procured) then 'PARTIAL' 
       when (t3.fuel_requirement <= t3.total_fuel_procured) then 'RESERVED' 
  else 'UNRESERVED' 
  end) as status
  from t3
  group by 2