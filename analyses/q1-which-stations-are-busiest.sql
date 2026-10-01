-- Question 1 (Member B): Which stations are the busiest?
-- Answer: E 21st/Speedway @ PCL, by a wide margin: 36,844 trips started there in 2025, 9.9% of all starts.
--         The 11 busiest stations hold 51.7% of all starts. 83 stations had at least one trip.
-- Scope:  current system, calendar year 2025. "Busy" counts trips that start there plus trips that end there.
-- What would make it wrong: a station counted twice under two names. dim_station keeps a renamed station as
--         two rows (three stations were renamed or moved in the current system), so each is ranked on its own.
--         None of the three is near the top 15.
WITH starts AS (
  SELECT start_station_key AS station_key, COUNT(*) AS trips_started
  FROM sample_bikeshare_star.fact_trip AS f
  JOIN sample_bikeshare_star.dim_date AS d ON d.date_key = f.date_key
  WHERE d.year = 2025
  GROUP BY 1
),
ends AS (
  SELECT end_station_key AS station_key, COUNT(*) AS trips_ended
  FROM sample_bikeshare_star.fact_trip AS f
  JOIN sample_bikeshare_star.dim_date AS d ON d.date_key = f.date_key
  WHERE d.year = 2025
  GROUP BY 1
),
per_station AS (
  SELECT
    st.station_name,
    IFNULL(s.trips_started, 0) AS trips_started,
    IFNULL(e.trips_ended, 0)   AS trips_ended
  FROM sample_bikeshare_star.dim_station AS st
  LEFT JOIN starts AS s ON s.station_key = st.station_key
  LEFT JOIN ends   AS e ON e.station_key = st.station_key
  WHERE st.system_name = 'current'
    AND (s.trips_started IS NOT NULL OR e.trips_ended IS NOT NULL)
)
SELECT
  RANK() OVER (ORDER BY trips_started + trips_ended DESC)            AS busy_rank,
  station_name,
  trips_started,
  trips_ended,
  ROUND(100 * trips_started / SUM(trips_started) OVER (), 1)          AS pct_of_all_starts,
  ROUND(100 * SUM(trips_started) OVER (ORDER BY trips_started + trips_ended DESC)
        / SUM(trips_started) OVER (), 1)                              AS running_pct_of_all_starts,
  COUNT(*) OVER ()                                                    AS stations_with_trips_in_2025
FROM per_station
ORDER BY busy_rank
LIMIT 15;
