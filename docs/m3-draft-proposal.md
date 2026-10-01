# Module 3: Draft Proposal

**Team:** Sample Team. **Stakeholder:** a senior planner in a city transportation department.

## Stakeholder and decision

The planner must decide, before next spring, where the city adds docks and where the rebalancing van goes. The
planner wants a one-page answer with numbers and has no time for a dashboard.

## Questions (draft)

1. Which stations are the busiest, and which are busy for their size (trips per dock)?
2. When do people ride (hour, weekday or weekend), and does it differ by rider type?
3. Which stations end the day with more bikes than they started with, and which with fewer?
4. How has ridership changed over the last three years?
5. Where should the city put new stations?

## What we have learned about the data so far

From our Module 2 and 3 weekly queries, each of us on our own BigQuery account:

- The trips table has 2,916,659 trips, from December 2013 to August 2026. It is 0.33 GB, so cost is not a worry.
- Trips per year in the last three full years: 283,964 in 2023, 252,498 in 2024 and 372,389 in 2025.
- Something happened in July 2024. That month has 2,035 trips. The months around it have 14,378 and 11,526.
  From late July 2024 the station ids are all new (10001 and up) and the bike type is a new value, "EFIT".
  It looks like the operator changed systems. We need to treat the two periods with care.
- The stations table has 101 stations. We have not yet checked how many of the stations in the trips are in it.

## Schema direction

A star schema with one fact table and three dimensions.

- **Fact:** trips, one row per trip.
- **Dimensions:** station (used twice, for start and end), date, rider type.
- Bike type and start hour stay on the fact as plain columns.

We chose one row per trip over a daily summary because the hour question and the rider question need single trips.

## Division of labour

| Member | Owns | First task |
|---|---|---|
| Member A | the trips cleaning step, the fact table, the date range, question 4 | write the cleaning view with a fixed date range |
| Member B | the station dimension, questions 1 and 3 | check the stations table against the stations in the trips |
| Member C | the date and rider type dimensions, the validation checks, question 2 | list every pass name and propose rider groups |

Each of us writes our own files and commits them under our own name. Anyone can run all of them.
We meet once a week for 45 minutes. Whoever is blocked says so in the team chat the same day.

## Paired read note

- **Read by:** Team Y, asynchronously (they left comments on our draft and we talked for ten minutes after Studio).
- **Three changes we are making:**
  1. **Drop question 5.** Team Y asked how trip counts could show where a station is missing. They cannot. The
     data only has stations that exist. We will keep to questions the trips can answer.
  2. **Fix the date range and write it down.** Team Y could not tell which years our numbers covered. We will use
     2023-01-01 to 2025-12-31 everywhere, three full calendar years.
  3. **Say which system each station answer is about.** Team Y pointed out that if the station ids changed in
     2024, a "busiest station" list over three years mixes two sets of stations. Station questions will use the
     current system, and we will say so in each answer.
