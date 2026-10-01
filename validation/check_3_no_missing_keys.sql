-- Check 3 (Member C). Does every trip point to a real row in every dimension?
SELECT
  'check 3: no missing keys' AS check_name,
  COUNTIF(ss.station_key IS NULL)    AS trips_without_start_station,
  COUNTIF(es.station_key IS NULL)    AS trips_without_end_station,
  COUNTIF(d.date_key IS NULL)        AS trips_without_date,
  COUNTIF(r.rider_type_key IS NULL)  AS trips_without_rider_type,
  IF(COUNTIF(ss.station_key IS NULL) + COUNTIF(es.station_key IS NULL)
     + COUNTIF(d.date_key IS NULL) + COUNTIF(r.rider_type_key IS NULL) = 0, 'PASS', 'FAIL') AS result
FROM sample_bikeshare_star.fact_trip AS f
LEFT JOIN sample_bikeshare_star.dim_station    AS ss ON ss.station_key = f.start_station_key
LEFT JOIN sample_bikeshare_star.dim_station    AS es ON es.station_key = f.end_station_key
LEFT JOIN sample_bikeshare_star.dim_date       AS d  ON d.date_key = f.date_key
LEFT JOIN sample_bikeshare_star.dim_rider_type AS r  ON r.rider_type_key = f.rider_type_key;
