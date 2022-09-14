SELECT
  format_number (sum(Fuel_In_Gallons)) AS total_fuel_available
FROM ( SELECT
    Fuel_In_Gallons
  FROM (
    SELECT
      CASE WHEN unit = 'litres' THEN
        cast(currentinventory / 3.785411784 AS decimal(10, 2))
      WHEN unit = 'barrel' THEN
        cast(currentinventory / 42 AS decimal(10, 2))
      ELSE
        currentinventory
      END Fuel_In_Gallons
    FROM
      "icebase"."mitreusaf".usaf_depot))