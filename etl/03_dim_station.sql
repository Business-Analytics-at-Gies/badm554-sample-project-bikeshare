-- 03_dim_station.sql   Owner: Member B
-- One row per station NAME in one SYSTEM (legacy or current), from both ends of every trip.
-- Why the name and not the id: one id can carry two names over time, and in 2023 the end station id
-- often disagrees with the end station name on the same trip. See docs/m6-recovery-note.md.
CREATE OR REPLACE TABLE sample_bikeshare_star.dim_station AS
WITH seen AS (
  SELECT system_name, start_station_name AS station_name, start_station_id AS station_id, trip_date
  FROM sample_bikeshare_star.stg_trips
  UNION ALL
  SELECT system_name, end_station_name, NULL, trip_date      -- end ids are not trusted, so not used
  FROM sample_bikeshare_star.stg_trips
),
per_station AS (
  SELECT
    system_name,
    station_name,
    MIN(station_id) AS source_station_id,     -- the id trips START with; empty if the name only appears as an end
    MIN(trip_date)  AS first_trip_date,
    MAX(trip_date)  AS last_trip_date
  FROM seen
  GROUP BY system_name, station_name
)
SELECT
  ROW_NUMBER() OVER (ORDER BY p.system_name, p.station_name) AS station_key,
  p.station_name,
  p.system_name,
  p.source_station_id,
  p.first_trip_date,
  p.last_trip_date,
  c.station_id IS NOT NULL AS in_city_list,
  c.number_of_docks,
  c.council_district
FROM per_station AS p
LEFT JOIN sample_bikeshare_star.stg_stations AS c
  ON p.system_name = 'legacy'      -- the city list only knows legacy ids
  AND c.station_id = CASE p.source_station_id
                       WHEN 2498 THEN 3794     -- these two ids are swapped between the trips and the city list
                       WHEN 3794 THEN 2498     -- (Dean Keeton/Speedway and 4th/Sabine)
                       ELSE p.source_station_id
                     END;
