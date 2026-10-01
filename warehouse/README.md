# warehouse/

Our tables live in BigQuery, in a dataset named `sample_bikeshare_star`. Nothing is stored in this folder.
The queries in `etl/` rebuild every table.

## Tables, grain and row counts

Built on 2026-09-30, after the station join fix.

| Table | Kind | One row is | Rows |
|---|---|---|---|
| `fact_trip` | table | one bike trip that started from 2023-01-01 to 2025-12-31 | 908,851 |
| `dim_station` | table | one station name in one system (legacy or current) | 171 |
| `dim_date` | table | one calendar day from 2023-01-01 to 2025-12-31 | 1,096 |
| `dim_rider_type` | table | one pass or membership name | 17 |
| `stg_trips` | view | one trip in the date range | 908,851 |
| `stg_stations` | view | one station in the city's station list | 101 |

Our first build had 935,544 rows in `fact_trip`. See `docs/m6-recovery-note.md`.
