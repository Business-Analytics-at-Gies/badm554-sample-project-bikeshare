-- Check 1 (Member A). Does the fact table have exactly the trips the public table has in our date range?
SELECT
  'check 1: row counts match the source' AS check_name,
  src.n  AS source_trips_in_range,
  stg.n  AS stg_trips_rows,
  fact.n AS fact_trip_rows,
  IF(src.n = stg.n AND stg.n = fact.n, 'PASS', 'FAIL') AS result
FROM
  (SELECT COUNT(*) AS n FROM `bigquery-public-data.austin_bikeshare.bikeshare_trips`
   WHERE start_time >= '2023-01-01' AND start_time < '2026-01-01') AS src,
  (SELECT COUNT(*) AS n FROM sample_bikeshare_star.stg_trips) AS stg,
  (SELECT COUNT(*) AS n FROM sample_bikeshare_star.fact_trip) AS fact;
