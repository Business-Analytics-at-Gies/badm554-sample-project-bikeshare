-- Check 5 (Member C). Do the calendar and the trips cover the same fixed date range, and are the only
-- days with no trips the 23 days of the July 2024 system change?
WITH trips_per_day AS (
  SELECT d.date_key, COUNT(f.trip_id) AS trips
  FROM sample_bikeshare_star.dim_date AS d
  LEFT JOIN sample_bikeshare_star.fact_trip AS f ON f.date_key = d.date_key
  GROUP BY d.date_key
)
SELECT
  'check 5: calendar and trips cover the same range' AS check_name,
  MIN(date_key)                       AS first_day,
  MAX(date_key)                       AS last_day,
  COUNT(*)                            AS calendar_days,
  COUNTIF(trips = 0)                  AS days_with_no_trips,
  MIN(IF(trips = 0, date_key, NULL))  AS first_empty_day,
  MAX(IF(trips = 0, date_key, NULL))  AS last_empty_day,
  IF(MIN(date_key) = '2023-01-01' AND MAX(date_key) = '2025-12-31' AND COUNT(*) = 1096
     AND MIN(IF(trips > 0, date_key, NULL)) = '2023-01-01' AND MAX(IF(trips > 0, date_key, NULL)) = '2025-12-31'
     AND COUNTIF(trips = 0) = 23
     AND MIN(IF(trips = 0, date_key, NULL)) = '2024-07-01'
     AND MAX(IF(trips = 0, date_key, NULL)) = '2024-07-23', 'PASS', 'FAIL') AS result
FROM trips_per_day;
