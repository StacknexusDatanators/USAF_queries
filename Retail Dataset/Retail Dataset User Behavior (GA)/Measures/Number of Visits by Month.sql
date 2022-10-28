SELECT date(date_parse(date, '%Y%m%d')) AS "Date",
       count(visitId) AS "Number Of Visit"
FROM icebase.merchandise_retail.ga_session_dataset
GROUP BY date(date_parse(date, '%Y%m%d'))