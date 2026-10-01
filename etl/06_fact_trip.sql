-- 06_fact_trip.sql   Owner: Member A
-- Grain: one row per bike trip that started inside the date range.
-- Stations are matched on system and cleaned name, never on the id (see docs/m6-recovery-note.md).
CREATE OR REPLACE TABLE sample_bikeshare_star.fact_trip AS
SELECT
  t.trip_id,
  t.trip_date          AS date_key,
  t.start_hour,
  ss.station_key       AS start_station_key,
  es.station_key       AS end_station_key,
  r.rider_type_key,
  t.bike_type,
  t.system_name,
  t.duration_minutes
FROM sample_bikeshare_star.stg_trips AS t
LEFT JOIN sample_bikeshare_star.dim_station AS ss
  ON ss.system_name = t.system_name AND ss.station_name = t.start_station_name
LEFT JOIN sample_bikeshare_star.dim_station AS es
  ON es.system_name = t.system_name AND es.station_name = t.end_station_name
LEFT JOIN sample_bikeshare_star.dim_rider_type AS r
  ON r.subscriber_type = t.subscriber_type;
