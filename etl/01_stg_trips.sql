-- 01_stg_trips.sql   Owner: Member A
-- A VIEW (a saved query, stores nothing). Picks the columns we need and fixes the date range.
-- The date range lives here: trips that started from 2023-01-01 up to, but not including, 2026-01-01.
CREATE OR REPLACE VIEW sample_bikeshare_star.stg_trips AS
SELECT
  trip_id,
  start_time,
  DATE(start_time)                    AS trip_date,
  EXTRACT(HOUR FROM start_time)       AS start_hour,
  start_station_id,
  SAFE_CAST(end_station_id AS INT64)  AS end_station_id,   -- the source stores this one as text
  start_station_name,
  end_station_name,
  subscriber_type,
  bike_type,
  duration_minutes
FROM `bigquery-public-data.austin_bikeshare.bikeshare_trips`
WHERE start_time >= '2023-01-01'
  AND start_time <  '2026-01-01';
