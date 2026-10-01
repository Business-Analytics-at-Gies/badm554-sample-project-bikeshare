# Module 6 recovery note: the station join

This is our recovery evidence for the Project Data Product. It records one wrong turn in the ETL, how we noticed,
and how we fixed it. The wrong version and the fix are both in the commit history (look for the commits that
start with "M6:" and touch `etl/03_dim_station.sql` and `etl/06_fact_trip.sql`).

## What we planned

In the final proposal, `dim_station` had one row per station id, and `fact_trip` joined to it on
`start_station_id` and `end_station_id`. We listed "station ids may not be stable" as our named risk, with
"key the station on its name" as the fallback.

Member B tested the risk before the build, but tested only half of it. The test asked: is any station id used in
both systems? The answer was no. Legacy ids run from 2494 to 7637 and current ids from 10001 to 10092. We read
that as "ids are stable" and went ahead. We never asked whether one id always has one name inside a system.

## What we built first

- `dim_station`: `SELECT DISTINCT start_station_id, start_station_name` from the trips, with docks from the city list.
- `fact_trip`: `stg_trips` joined to `dim_station` twice, on the start id and on the end id.

## How we noticed

Member A ran the join on one month before building the full table, as the course page suggests.

| | January 2023 |
|---|---|
| Trips in `stg_trips` | 22,052 |
| Rows after the join | 22,180 |

128 extra rows in one month. We built the full table anyway to see the size of the problem, and Member C's row
count step showed it:

| Table | Rows | Different trip ids |
|---|---|---|
| `stg_trips` | 908,851 | 908,851 |
| `fact_trip` (first build) | 935,544 | 908,851 |
| `dim_station` (first build) | 167 | 163 station ids |

26,693 extra rows. By year: 972 in 2023, 5,546 in 2024 and 20,175 in 2025. Any count of trips from this table
would have been too high, and most of all in 2025, the year the planner cares about most.

## Cause 1: one id, two names

`dim_station` had 167 rows for 163 ids. Four ids had two rows each:

| Station id | Names |
|---|---|
| 4055 | "11th/Salina" and "11th/Salina " (with a trailing space) |
| 10023 | "E 4th/Neches @ Downtown Station" and "E 5th/Neches @ Downtown Station" |
| 10053 | "E 6th/Robert T. Martinez" and "E 6th/Chicon" |
| 10058 | "Lakeshore/Austin Hostel" and "Lakeshore/Lady Bird Ln." |

One is a typing difference. Three are stations that were renamed or moved and kept their id. Every trip that
started or ended at one of these ids matched two rows in `dim_station`, so it appeared twice in the fact (four
times if both ends were affected). This is a fan-out join.

## Cause 2: the end station id cannot be trusted

While reading the duplicates, Member B compared the end station name on each trip with the name the end id
pointed to. This problem would not have shown up in any row count.

| Year | Trips | Trips whose end id does not lead to the end name on the trip |
|---|---|---|
| 2023 | 283,964 | 47,175 |
| 2024 | 252,498 | 323 |
| 2025 | 372,389 | 297 |

In 2023, one trip in six carried an end id that does not belong to the station the trip names. For example, trips that name
"21st/Speedway @ PCL" as the end station in 2023 carry 59 different end ids. The name on the trip is consistent and never
empty. The id is the unreliable part. A fact table joined on the end id would have sent 47,175 trips in 2023 to
the wrong station, with correct row counts. Our question 3 (which stations gain or lose bikes) depends completely
on the end station.

## The fix

1. `01_stg_trips.sql` (Member A): clean the station names. All whitespace becomes a single space and the ends are
   trimmed. It also adds `system_name`, legacy or current, because the same name can exist in both systems.
2. `03_dim_station.sql` (Member B): one row per station name per system, taken from both the start and the end
   of every trip. The id is kept as `source_station_id`, for reference only. A new `station_key` is the key.
3. `06_fact_trip.sql` (Member A): join to `dim_station` on system and name, never on the id.

## After the fix

| Table | Rows | Different trip ids |
|---|---|---|
| `stg_trips` | 908,851 | 908,851 |
| `fact_trip` | 908,851 | 908,851 |
| `dim_station` | 171 | 171 station keys |

`dim_station` went from 167 rows to 171. The two spellings of "11th/Salina" became one row, and five stations
that only appear as the end of a trip were added. Renamed stations stay as separate rows on purpose.

## What we added so it cannot come back quietly

- Check 2 (one row per trip) catches the fan-out.
- Check 4 (one row per station name per system) catches the cause of the fan-out.
- Check 6 (station names match the source trip) catches the wrong end station. It compares all 908,851 trips.

## What we learned

A matching row count told us the first problem existed. It could not have told us about the second one. We only
found the second because we were already looking at station names by eye. The check we rely on most now is the one
that compares our rows with the source, value by value.

The AI assistant drafted the first join for us and joined on the ids. That was a reasonable reading of the column
names. The mistake was ours: we accepted it without counting names per id first. It is in the AI Attribution Log.
