-- 07_row_counts.sql   Owner: Member C
-- Last step of the build. Prints the row count of every table, to compare with warehouse/README.md.
SELECT 'dim_date' AS table_name, COUNT(*) AS row_count FROM sample_bikeshare_star.dim_date
UNION ALL SELECT 'dim_rider_type', COUNT(*) FROM sample_bikeshare_star.dim_rider_type
UNION ALL SELECT 'dim_station',    COUNT(*) FROM sample_bikeshare_star.dim_station
UNION ALL SELECT 'fact_trip',      COUNT(*) FROM sample_bikeshare_star.fact_trip
UNION ALL SELECT 'stg_trips (view)',    COUNT(*) FROM sample_bikeshare_star.stg_trips
UNION ALL SELECT 'stg_stations (view)', COUNT(*) FROM sample_bikeshare_star.stg_stations
ORDER BY table_name;
