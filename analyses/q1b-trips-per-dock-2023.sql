-- Question 1, second part (Member B): Which stations are busy for their size?
-- Answer: 21st/Speedway @ PCL had 4.06 trip starts per dock per day in 2023 (22 docks, 32,639 starts).
--         Next were 26th/Nueces (2.67) and Dean Keeton/Speedway (2.48).
-- Scope:  legacy system only, calendar year 2023, the 71 legacy stations found in the city station list.
--         The city list has no dock count for any current-system station, so this cannot be done for 2025.
-- What would make it wrong: dock counts that changed since the city list was last edited (2021 and 2022).
--         We cannot check that from this data.
-- Explained in: analyses/README.md and reports/final-report.md (question 1).
SELECT
  st.station_name,
  st.number_of_docks,
  COUNT(*) AS trips_started_2023,
  ROUND(COUNT(*) / 365 / st.number_of_docks, 2) AS starts_per_dock_per_day
FROM sample_bikeshare_star.fact_trip AS f
JOIN sample_bikeshare_star.dim_date    AS d  ON d.date_key = f.date_key
JOIN sample_bikeshare_star.dim_station AS st ON st.station_key = f.start_station_key
WHERE d.year = 2023
  AND st.number_of_docks IS NOT NULL
GROUP BY st.station_name, st.number_of_docks
ORDER BY starts_per_dock_per_day DESC
LIMIT 10;
