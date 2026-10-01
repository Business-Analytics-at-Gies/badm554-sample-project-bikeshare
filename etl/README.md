# etl/

Back to the [project README](../README.md)

The queries that build our tables. Run them in number order. Each file says who owns it at the top.

| File | What it makes | Kind | Owner |
|---|---|---|---|
| [`01_stg_trips.sql`](01_stg_trips.sql) | `stg_trips`: the trips we use, with clean station names and the fixed date range | view | Member A |
| [`02_stg_stations.sql`](02_stg_stations.sql) | `stg_stations`: the city's station list, only the columns we use | view | Member B |
| [`03_dim_station.sql`](03_dim_station.sql) | `dim_station`: one row per station name per system | table | Member B |
| [`04_dim_date.sql`](04_dim_date.sql) | `dim_date`: one row per calendar day | table | Member C |
| [`05_dim_rider_type.sql`](05_dim_rider_type.sql) | `dim_rider_type`: one row per pass name, with a rider group | table | Member C |
| [`06_fact_trip.sql`](06_fact_trip.sql) | `fact_trip`: one row per trip | table | Member A |
| [`07_row_counts.sql`](07_row_counts.sql) | prints the row count of every table | query | Member C |
| [`run_all.sh`](run_all.sh) | runs 01 to 07 in order | script | Member A |

## Things to know

- **The date range is fixed.** Trips that started from 2023-01-01 up to, but not including, 2026-01-01. It is
  written in `01_stg_trips.sql`, and `04_dim_date.sql` builds the calendar for the same days. The public table
  keeps growing, and this keeps our counts the same.
- **Cleaning steps are views. The star is tables.** A view is a saved query and stores nothing. The tables are
  built with `CREATE OR REPLACE TABLE`, so running everything a second time gives the same row counts.
- **No project name in any query.** Tables are written as `sample_bikeshare_star.fact_trip`. Your own project is
  set once, when you run the script or pick a project in the BigQuery console.
- **Order matters.** `06_fact_trip.sql` reads the three dimension tables, so they must exist first.

## Two ways to run it

1. With the `bq` command line tool: `sh etl/run_all.sh YOUR_PROJECT_ID`. After a first build, add the word `dry` at
   the end to see how many bytes each step would scan without running anything.
2. In the BigQuery console: make a dataset named `sample_bikeshare_star` in your own project, then paste each file
   in number order and run it.

The whole build scans about 0.54 GB.

Related: [the row counts](../warehouse/README.md) · [the schema and its grain](../docs/schema.md) · [the checks](../validation/README.md) · [why stations join on the name](../docs/m6-recovery-note.md)
