-- 01_stg_trips.sql   Owner: Member A
-- A VIEW (a saved query, stores nothing). Picks the columns we need, cleans the station names,
-- and fixes the date range.
-- The date range lives here: trips that started from 2023-01-01 up to, but not including, 2026-01-01.
-- (04_dim_date.sql uses the same two dates.)
CREATE OR REPLACE VIEW sample_bikeshare_star.stg_trips AS
SELECT
  trip_id,
  start_time,
  DATE(start_time)                    AS trip_date,
  EXTRACT(HOUR FROM start_time)       AS start_hour,
  -- The operator changed systems in July 2024. No trips exist from 2024-07-01 to 2024-07-23.
  -- Station ids and many station names are different before and after.
  IF(DATE(start_time) < '2024-07-01', 'legacy', 'current') AS system_name,
  start_station_id,
  -- Names carry stray tabs and trailing spaces in the source. Squash all whitespace to single spaces.
  TRIM(REGEXP_REPLACE(start_station_name, r'\s+', ' ')) AS start_station_name,
  TRIM(REGEXP_REPLACE(end_station_name,   r'\s+', ' ')) AS end_station_name,
  subscriber_type,
  bike_type,
  duration_minutes
FROM `bigquery-public-data.austin_bikeshare.bikeshare_trips`
WHERE start_time >= '2023-01-01'
  AND start_time <  '2026-01-01';
