# warehouse/

Our tables live in BigQuery, in a dataset named `sample_bikeshare_star`. Nothing is stored in this folder.
The queries in `etl/` rebuild every table, so there is no file to download.

For this sample the dataset was built in the course project, as `badm554:sample_bikeshare_star`. Tables and views in it
expire 30 days after they are built. When you rebuild, the tables go into the same dataset name in your own project.

## Tables, grain and row counts

Built on 2026-09-30. Built a second time the same day, from a fresh clone: same counts.

| Table | Kind | One row is | Rows |
|---|---|---|---|
| `fact_trip` | table | one bike trip that started from 2023-01-01 to 2025-12-31 | 908,851 |
| `dim_station` | table | one station name in one system (legacy or current) | 171 |
| `dim_date` | table | one calendar day from 2023-01-01 to 2025-12-31 | 1,096 |
| `dim_rider_type` | table | one pass or membership name | 17 |
| `stg_trips` | view | one trip in the date range, before the station and rider keys are added | 908,851 |
| `stg_stations` | view | one station in the city's station list | 101 |

`etl/07_row_counts.sql` prints these counts. If yours differ, something changed. The most likely cause is an
edited date range.

## A little more detail

- `fact_trip` has 283,964 trips in 2023, 252,498 in 2024 and 372,389 in 2025.
- `dim_station` has 83 legacy stations and 88 current stations. 71 of the legacy stations are in the city list
  and have a dock count. No current station does.
- `dim_date` has 24 days with no trips: 2023-02-01, and 2024-07-01 to 2024-07-23 (the system change).
