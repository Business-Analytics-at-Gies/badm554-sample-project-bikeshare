-- 02_stg_stations.sql   Owner: Member B
-- A VIEW over the city's station list. Picks the columns we use.
CREATE OR REPLACE VIEW sample_bikeshare_star.stg_stations AS
SELECT
  station_id,
  name              AS city_station_name,
  status,
  number_of_docks,
  council_district
FROM `bigquery-public-data.austin_bikeshare.bikeshare_stations`;
