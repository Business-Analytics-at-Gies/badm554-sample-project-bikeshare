-- 03_dim_station.sql   Owner: Member B
-- One row per station. Station ids and names come from the trips, docks and district from the city list.
CREATE OR REPLACE TABLE sample_bikeshare_star.dim_station AS
WITH trip_stations AS (
  SELECT DISTINCT start_station_id AS station_id, start_station_name AS station_name
  FROM sample_bikeshare_star.stg_trips
)
SELECT
  t.station_id,
  t.station_name,
  c.number_of_docks,
  c.council_district,
  c.status
FROM trip_stations AS t
LEFT JOIN sample_bikeshare_star.stg_stations AS c
  ON c.station_id = t.station_id;
