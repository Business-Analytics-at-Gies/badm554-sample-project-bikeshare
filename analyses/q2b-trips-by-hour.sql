-- Question 2, second part (Member C): the hour-by-hour picture for all riders, 2025.
-- Answer: on weekdays the busiest hour is 5 PM (91.5 trips), after a morning rise from 7 AM (30.6) to
--         8 AM (52.8). Weekends have no morning rise and no clear peak: 69 to 72 trips in each hour from 1 PM to 5 PM.
-- Scope:  average trips started in each hour on a weekday and on a weekend day, calendar year 2025.
-- What would make it wrong: the hours are read as local Austin time; the source does not say so.
-- Explained in: analyses/README.md and reports/final-report.md (question 2).
WITH day_counts AS (
  SELECT COUNTIF(NOT is_weekend) AS weekdays, COUNTIF(is_weekend) AS weekend_days
  FROM sample_bikeshare_star.dim_date WHERE year = 2025
)
SELECT
  f.start_hour,
  ROUND(COUNTIF(NOT d.is_weekend) / ANY_VALUE(c.weekdays), 1)     AS trips_per_weekday,
  ROUND(COUNTIF(d.is_weekend)     / ANY_VALUE(c.weekend_days), 1) AS trips_per_weekend_day
FROM sample_bikeshare_star.fact_trip AS f
JOIN sample_bikeshare_star.dim_date AS d ON d.date_key = f.date_key
CROSS JOIN day_counts AS c
WHERE d.year = 2025
GROUP BY f.start_hour
ORDER BY f.start_hour;
