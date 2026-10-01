-- Question 4, second part (Member A): the yearly totals, with bike type and typical trip length.
-- Answer: 283,964 trips in 2023, 252,498 in 2024 (down 11.1%, with the July gap), 372,389 in 2025
--         (up 31.1% on 2023). The median trip got shorter: 8.0, then 7.7, then 7.1 minutes.
-- What would make it wrong: comparing bike types across the system change. The legacy system had classic
--         and electric bikes; in the current system every trip but one is on a single electric model (called EFIT in the data).
SELECT
  d.year,
  COUNT(*)                                   AS trips,
  ROUND(100 * (COUNT(*) - FIRST_VALUE(COUNT(*)) OVER (ORDER BY d.year))
        / FIRST_VALUE(COUNT(*)) OVER (ORDER BY d.year), 1) AS pct_change_vs_2023,
  COUNTIF(f.system_name = 'legacy')          AS trips_legacy_system,
  COUNTIF(f.system_name = 'current')         AS trips_current_system,
  COUNTIF(f.bike_type = 'classic')           AS classic_bike_trips,
  COUNTIF(f.bike_type IN ('electric', 'EFIT')) AS electric_bike_trips,
  ROUND(APPROX_QUANTILES(f.duration_minutes, 100)[OFFSET(50)], 1) AS median_minutes,
  COUNTIF(f.duration_minutes > 1440)         AS trips_longer_than_a_day
FROM sample_bikeshare_star.fact_trip AS f
JOIN sample_bikeshare_star.dim_date AS d ON d.date_key = f.date_key
GROUP BY d.year
ORDER BY d.year;
