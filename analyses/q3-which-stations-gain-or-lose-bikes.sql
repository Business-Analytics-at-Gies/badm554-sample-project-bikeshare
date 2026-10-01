-- Question 3 (Member B): Which stations end up with more bikes than they started with, and which with fewer?
-- Answer: Dean Keeton/Speedway gains the most: 6,663 more trips ended there than started there in 2025,
--         about 18.3 bikes a day. W 22nd/Pearl (10.1 a day) and W 26th/Nueces (9.0 a day) lose the most.
-- Scope:  current system, calendar year 2025. Net = trips that ended here minus trips that started here.
--         A positive net means bikes pile up (the van takes bikes away). A negative net means the station empties.
-- What would make it wrong: the trips table only shows rides. Bikes moved by the operator's van are not in
--         it, so this is the imbalance riders create, before any rebalancing.
-- Explained in: analyses/README.md and reports/final-report.md (question 3).
WITH starts AS (
  SELECT start_station_key AS station_key, COUNT(*) AS trips_started
  FROM sample_bikeshare_star.fact_trip AS f
  JOIN sample_bikeshare_star.dim_date AS d ON d.date_key = f.date_key
  WHERE d.year = 2025 GROUP BY 1
),
ends AS (
  SELECT end_station_key AS station_key, COUNT(*) AS trips_ended
  FROM sample_bikeshare_star.fact_trip AS f
  JOIN sample_bikeshare_star.dim_date AS d ON d.date_key = f.date_key
  WHERE d.year = 2025 GROUP BY 1
),
net AS (
  SELECT
    st.station_name,
    IFNULL(s.trips_started, 0) AS trips_started,
    IFNULL(e.trips_ended, 0)   AS trips_ended,
    IFNULL(e.trips_ended, 0) - IFNULL(s.trips_started, 0) AS net_bikes_2025
  FROM sample_bikeshare_star.dim_station AS st
  LEFT JOIN starts AS s ON s.station_key = st.station_key
  LEFT JOIN ends   AS e ON e.station_key = st.station_key
  WHERE st.system_name = 'current'
    AND (s.trips_started IS NOT NULL OR e.trips_ended IS NOT NULL)
)
SELECT
  CASE WHEN net_bikes_2025 > 0 THEN 'gains bikes' WHEN net_bikes_2025 < 0 THEN 'loses bikes' ELSE 'balanced' END AS direction,
  station_name, trips_started, trips_ended, net_bikes_2025,
  ROUND(net_bikes_2025 / 365, 1) AS net_bikes_per_day
FROM net
QUALIFY ROW_NUMBER() OVER (ORDER BY net_bikes_2025 DESC) <= 6
     OR ROW_NUMBER() OVER (ORDER BY net_bikes_2025 ASC)  <= 6
ORDER BY net_bikes_2025 DESC;
