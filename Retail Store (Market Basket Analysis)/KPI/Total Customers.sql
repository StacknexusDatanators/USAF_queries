SELECT
  format_number (total_users)
FROM (
  SELECT
    count(DISTINCT user_id) AS total_users
  FROM
    "icebase"."retail_store".orders)