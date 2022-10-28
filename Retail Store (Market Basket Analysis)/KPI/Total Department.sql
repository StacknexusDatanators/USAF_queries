SELECT
  format_number (total_department) AS total_department
FROM (
  SELECT
    count(DISTINCT department_id) AS total_department
  FROM
    "icebase"."retail_store".departments
)