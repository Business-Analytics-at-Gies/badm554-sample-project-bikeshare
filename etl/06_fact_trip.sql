-- 06_fact_trip.sql   Owner: Member A
-- Grain: one row per bike trip that started inside the date range.
CREATE OR REPLACE TABLE sample_bikeshare_star.fact_trip AS
SELECT
  t.trip_id,
  t.trip_date          AS date_key,
  t.start_hour,
  ss.station_id        AS start_station_id,
  es.station_id        AS end_station_id,
  r.rider_type_key,
  t.bike_type,
  t.duration_minutes
FROM sample_bikeshare_star.stg_trips AS t
LEFT JOIN sample_bikeshare_star.dim_station    AS ss ON ss.station_id = t.start_station_id
LEFT JOIN sample_bikeshare_star.dim_station    AS es ON es.station_id = t.end_station_id
LEFT JOIN sample_bikeshare_star.dim_rider_type AS r  ON r.subscriber_type = t.subscriber_type;
