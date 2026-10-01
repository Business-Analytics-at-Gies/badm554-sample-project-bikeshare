-- Question 2 (Member C): When do people ride, and does it differ by rider type?
-- Answer: annual members ride mostly on weekdays (727.2 trips per weekday, 465.6 per weekend day) and their
--         trips are short (median 5.4 minutes on weekdays). Casual riders are the opposite: 86.4 trips per
--         weekday, 200.5 per weekend day, median 21.0 to 22.7 minutes.
-- Scope:  current system, calendar year 2025. One row per rider group and weekday or weekend.
-- What would make it wrong: (1) the hours are read as local Austin time; the source does not say so.
--         (2) Rider groups are our own grouping of pass names (see etl/05_dim_rider_type.sql).
-- Explained in: analyses/README.md and reports/final-report.md (question 2).
WITH day_counts AS (
  SELECT is_weekend, COUNT(*) AS days FROM sample_bikeshare_star.dim_date WHERE year = 2025 GROUP BY is_weekend
),
trips AS (
  SELECT r.rider_group, d.is_weekend, f.start_hour, f.duration_minutes
  FROM sample_bikeshare_star.fact_trip AS f
  JOIN sample_bikeshare_star.dim_date       AS d ON d.date_key = f.date_key
  JOIN sample_bikeshare_star.dim_rider_type AS r ON r.rider_type_key = f.rider_type_key
  WHERE d.year = 2025
)
SELECT
  t.rider_group,
  IF(t.is_weekend, 'weekend', 'weekday') AS day_type,
  COUNT(*)                                AS trips,
  ROUND(COUNT(*) / ANY_VALUE(c.days), 1)  AS trips_per_day,
  ROUND(100 * COUNTIF(t.start_hour BETWEEN 7 AND 9)   / COUNT(*), 1) AS pct_started_7_to_9am,
  ROUND(100 * COUNTIF(t.start_hour BETWEEN 16 AND 18) / COUNT(*), 1) AS pct_started_4_to_6pm,
  ROUND(APPROX_QUANTILES(t.duration_minutes, 100)[OFFSET(50)], 1)    AS median_minutes
FROM trips AS t
JOIN day_counts AS c ON c.is_weekend = t.is_weekend
GROUP BY t.rider_group, t.is_weekend
ORDER BY t.rider_group, day_type;
