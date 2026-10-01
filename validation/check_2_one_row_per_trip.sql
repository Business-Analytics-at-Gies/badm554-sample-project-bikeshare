-- Check 2 (Member A). Is the grain true: one row per trip, no trip twice?
SELECT
  'check 2: one row per trip' AS check_name,
  COUNT(*)                            AS fact_rows,
  COUNT(DISTINCT trip_id)             AS distinct_trip_ids,
  COUNT(*) - COUNT(DISTINCT trip_id)  AS extra_rows,
  IF(COUNT(*) = COUNT(DISTINCT trip_id), 'PASS', 'FAIL') AS result
FROM sample_bikeshare_star.fact_trip;
