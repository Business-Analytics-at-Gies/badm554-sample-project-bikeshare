-- Check 5 (Member C). Do the calendar and the trips cover the same fixed date range, and are the only
-- days with no trips the ones we know about? We know of 24: 2023-02-01 (the source has no trips that
-- day either) and the 23 days of the July 2024 system change (2024-07-01 to 2024-07-23).
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
  COUNTIF(trips = 0 AND date_key != '2023-02-01'
          AND date_key NOT BETWEEN '2024-07-01' AND '2024-07-23') AS unexpected_empty_days,
  IF(MIN(date_key) = '2023-01-01' AND MAX(date_key) = '2025-12-31' AND COUNT(*) = 1096
     AND MIN(IF(trips > 0, date_key, NULL)) = '2023-01-01' AND MAX(IF(trips > 0, date_key, NULL)) = '2025-12-31'
     AND COUNTIF(trips = 0) = 24
     AND COUNTIF(trips = 0 AND date_key != '2023-02-01'
                 AND date_key NOT BETWEEN '2024-07-01' AND '2024-07-23') = 0, 'PASS', 'FAIL') AS result
FROM trips_per_day;
