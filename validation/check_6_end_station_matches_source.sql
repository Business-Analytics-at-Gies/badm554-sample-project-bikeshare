-- Check 6 (Member B). For every trip, do the start and end station names in the star equal the
-- (cleaned) names on the same trip in the public table? This is the check our first build would have failed.
SELECT
  'check 6: station names match the source trip' AS check_name,
  COUNT(*) AS trips_compared,
  COUNTIF(ss.station_name != TRIM(REGEXP_REPLACE(src.start_station_name, r'\s+', ' '))) AS start_name_differs,
  COUNTIF(es.station_name != TRIM(REGEXP_REPLACE(src.end_station_name,   r'\s+', ' '))) AS end_name_differs,
  IF(COUNT(*) = (SELECT COUNT(*) FROM sample_bikeshare_star.fact_trip)
     AND COUNTIF(ss.station_name != TRIM(REGEXP_REPLACE(src.start_station_name, r'\s+', ' '))) = 0
     AND COUNTIF(es.station_name != TRIM(REGEXP_REPLACE(src.end_station_name,   r'\s+', ' '))) = 0,
     'PASS', 'FAIL') AS result
FROM sample_bikeshare_star.fact_trip AS f
JOIN `bigquery-public-data.austin_bikeshare.bikeshare_trips` AS src ON src.trip_id = f.trip_id
JOIN sample_bikeshare_star.dim_station AS ss ON ss.station_key = f.start_station_key
JOIN sample_bikeshare_star.dim_station AS es ON es.station_key = f.end_station_key;
