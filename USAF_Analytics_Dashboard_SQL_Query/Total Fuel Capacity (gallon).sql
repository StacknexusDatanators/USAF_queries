SELECT
  format_number (sum(Fuel_In_Gallons)) AS total_fuel_capacity
FROM ( SELECT DISTINCT
    Fuel_In_Gallons
  FROM (
    SELECT
      CASE WHEN unit = 'litres' THEN
        cast(capacity / 3.785411784 AS decimal(10, 2))
      WHEN unit = 'barrel' THEN
        cast(capacity / 42 AS decimal(10, 2))
      ELSE
        capacity
      END Fuel_In_Gallons
    FROM
      "icebase"."mitreusaf".usaf_depot))
