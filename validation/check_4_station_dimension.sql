-- Check 4 (Member B). Is dim_station one row per station name per system, with ids on the right side
-- of the July 2024 system change (legacy ids are below 10000, current ids are 10001 and up)?
SELECT
  'check 4: station dimension is clean' AS check_name,
  COUNT(*)                                                        AS stations,
  COUNT(DISTINCT station_key)                                     AS distinct_keys,
  COUNT(DISTINCT CONCAT(system_name, '|', station_name))          AS distinct_system_and_name,
  COUNTIF(system_name = 'legacy'  AND source_station_id >= 10000) AS legacy_rows_with_current_id,
  COUNTIF(system_name = 'current' AND source_station_id <  10000) AS current_rows_with_legacy_id,
  IF(COUNT(*) = COUNT(DISTINCT station_key)
     AND COUNT(*) = COUNT(DISTINCT CONCAT(system_name, '|', station_name))
     AND COUNTIF(system_name = 'legacy'  AND source_station_id >= 10000) = 0
     AND COUNTIF(system_name = 'current' AND source_station_id <  10000) = 0, 'PASS', 'FAIL') AS result
FROM sample_bikeshare_star.dim_station;
