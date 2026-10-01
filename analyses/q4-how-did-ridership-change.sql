-- Question 4 (Member A): How did ridership change across the three years?
-- Answer: 2025 was above 2023 in every month except January (down 7.9%). The biggest rise was April
--         (27,621 trips in 2023, 44,547 in 2025, up 61.3%). October was the busiest month in 2023 and 2025.
-- Scope:  trips per month, one column per year.
-- What would make it wrong: reading 2024 as a normal year. The operator changed systems in July 2024 and
--         there are no trips at all from July 1 to July 23, so July 2024 shows only 2,035 trips.
-- Explained in: analyses/README.md and reports/final-report.md (question 4).
SELECT
  d.month,
  COUNTIF(d.year = 2023) AS trips_2023,
  COUNTIF(d.year = 2024) AS trips_2024,
  COUNTIF(d.year = 2025) AS trips_2025,
  ROUND(100 * (COUNTIF(d.year = 2025) - COUNTIF(d.year = 2023)) / COUNTIF(d.year = 2023), 1) AS pct_change_2023_to_2025
FROM sample_bikeshare_star.fact_trip AS f
JOIN sample_bikeshare_star.dim_date AS d ON d.date_key = f.date_key
GROUP BY d.month
ORDER BY d.month;
