-- 04_dim_date.sql   Owner: Member C
-- One row per calendar day in the project's date range (the same range as 01_stg_trips.sql).
CREATE OR REPLACE TABLE sample_bikeshare_star.dim_date AS
SELECT
  d                                   AS date_key,
  EXTRACT(YEAR FROM d)                AS year,
  EXTRACT(MONTH FROM d)               AS month,
  FORMAT_DATE('%Y-%m', d)             AS year_month,
  FORMAT_DATE('%A', d)                AS day_name,
  EXTRACT(DAYOFWEEK FROM d) IN (1, 7) AS is_weekend      -- 1 is Sunday, 7 is Saturday
FROM UNNEST(GENERATE_DATE_ARRAY('2023-01-01', '2025-12-31')) AS d;
