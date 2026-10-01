-- Check 7 (Member C). One monthly total, counted two ways. June 2025 trips and total minutes in the star
-- (through dim_date) against the same month counted straight from the public table.
SELECT
  'check 7: June 2025 matches the source' AS check_name,
  star.trips AS star_trips, src.trips AS source_trips,
  ROUND(star.minutes) AS star_minutes, ROUND(src.minutes) AS source_minutes,
  IF(star.trips = src.trips AND ABS(star.minutes - src.minutes) < 0.01, 'PASS', 'FAIL') AS result
FROM
  (SELECT COUNT(*) AS trips, SUM(f.duration_minutes) AS minutes
   FROM sample_bikeshare_star.fact_trip AS f
   JOIN sample_bikeshare_star.dim_date AS d ON d.date_key = f.date_key
   WHERE d.year_month = '2025-06') AS star,
  (SELECT COUNT(*) AS trips, SUM(duration_minutes) AS minutes
   FROM `bigquery-public-data.austin_bikeshare.bikeshare_trips`
   WHERE start_time >= '2025-06-01' AND start_time < '2025-07-01') AS src;
