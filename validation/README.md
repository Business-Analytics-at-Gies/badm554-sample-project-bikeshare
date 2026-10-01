# validation/

Back to the [project README](../README.md)

In the course, each member's Module 7 assignment adds three checks, with written predictions first. That
individual work is not shown here. The checks below are the team's project checks.

Seven checks. Each is one query that returns one row ending in `PASS` or `FAIL`.
Run them all with `sh validation/run_checks.sh YOUR_PROJECT_ID` ([the script](run_checks.sh)), or paste each file into the BigQuery console.

Last run: 2026-09-30, after a rebuild from a fresh clone. All seven passed.

| Check | What it checks | What it found | What pass or fail means | What it cannot see |
|---|---|---|---|---|
| [1. Row counts match the source](check_1_row_counts_match_source.sql) (Member A) | The public table, `stg_trips` and `fact_trip` have the same number of trips in the date range | 908,851 in all three | Pass: no trip was lost or added on the way. Fail: a filter or a join changed the count. | Whether the values in the rows are right. A trip with the wrong end station still counts as one row. |
| [2. One row per trip](check_2_one_row_per_trip.sql) (Member A) | No `trip_id` appears twice in `fact_trip` | 908,851 rows, 908,851 different trip ids, 0 extra | Pass: the grain is true. Fail: a join multiplied rows. | Two different trips that are really one ride recorded twice under two ids. |
| [3. No missing keys](check_3_no_missing_keys.sql) (Member C) | Every trip points to a real row in `dim_station` (start and end), `dim_date` and `dim_rider_type` | 0 trips without a match, for all four keys | Pass: every analysis that joins to a dimension keeps every trip. Fail: some trips drop out of joined results. | Whether the trip points to the correct row. It only checks that a row exists. |
| [4. Station dimension is clean](check_4_station_dimension.sql) (Member B) | One row per station name per system, and no legacy id on a current station or the other way round | 171 stations, 171 keys, 171 name and system pairs, 0 ids on the wrong side | Pass: a join to `dim_station` cannot multiply trips. Fail: the fan-out from our first build is back. | Two names for the same physical place. The same corner is one row in the legacy system and another in the current one. The id test also skips the five stations that have no id. |
| [5. Calendar matches the trips](check_5_calendar.sql) (Member C) | `dim_date` covers exactly 2023-01-01 to 2025-12-31, and the only days with no trips are the 24 we know about | 1,096 days, 24 with no trips, 0 unexpected | Pass: the date range is the same in the calendar and the trips. Fail: the range drifted, or a new gap appeared. | Days with too few trips. A day with 14 trips passes the same as a day with 700. |
| [6. Station names match the source trip](check_6_end_station_matches_source.sql) (Member B) | For every trip, the start and end station names in the star equal the cleaned names on that trip in the public table | 908,851 trips compared, 0 start names differ, 0 end names differ | Pass: every trip is attached to the station it names. Fail: trips are attached to the wrong station. | Mistakes in the source itself. If the public table names the wrong station, so do we. It also cleans the source name the same way our view does, so a mistake in the cleaning rule would pass. |
| [7. One month matches the source](check_7_one_month_matches_source.sql) (Member C) | June 2025, counted through `dim_date` in the star and counted straight from the public table | 22,492 trips and 409,487 minutes both ways | Pass: a monthly total from the star can be trusted. Fail: the date key or the calendar is off. | The other 35 months. We picked one. |

## Two checks that taught us something

**Check 6 exists because of our first build.** Checks 1 to 3 are the usual ones. Our first `fact_trip` would have
failed check 2. After we fixed the row count, a second problem was still there and no count showed it: in 2023,
47,175 trips pointed to an end station whose name was different from the name on the trip. Check 6 is the one that
sees it. The full story is in [`docs/m6-recovery-note.md`](../docs/m6-recovery-note.md).

**Check 5 failed the first time, and the pipeline was right.** We expected 23 days with no trips, the days of the
July 2024 system change. The check found 24. The extra day is 2023-02-01. The public table has no trips that day
either (14 the day before, 119 the day after). So our expectation was wrong and the tables were fine. We changed
the check to list the 24 days we now know about. We think the cause was the ice storm in Austin that week, but we
did not confirm it with the operator.

## What all seven together still cannot tell you

They compare our tables with the public table and with themselves. They cannot tell you whether the public table
is complete, whether the hours are local time, or whether our rider groups are the right way to group pass names.
Those are written down as assumptions in [`docs/schema.md`](../docs/schema.md).

Related: [the row counts](../warehouse/README.md) · [the recovery note](../docs/m6-recovery-note.md) · [the assumptions in the schema](../docs/schema.md) · [the build queries](../etl/README.md)
