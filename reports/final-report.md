# Where Austin's shared bikes are used, and where they pile up

Back to the [project README](../README.md)

**Team:** Sample Team. **Date:** Module 8. **Stakeholder:** a senior planner in a city transportation department.

## The question

Before next spring you have to decide where the city adds docks and where the rebalancing van goes. You asked
four things: which stations are busiest, when people ride, where bikes pile up or run out, and whether the
system is growing.

## The data

Two public tables in BigQuery: every bike trip (one row per trip) and the city's list of stations. We used the
908,851 trips that started from January 1, 2023 to December 31, 2025.

Three limits you should know before reading the answers.

- **The system changed in July 2024.** There are no trips at all from July 1 to July 23, 2024. After that gap
  every station has a new id, many have a new name, and the pass names are different. We read this as the
  operator moving to a new system. We did not confirm it with the operator. We treat
  the old ("legacy") and new ("current") systems separately. Station answers below are for the current system
  in 2025.
- **We have dock counts only for the old system.** The city's station list covers 71 of the 83 legacy stations
  and none of the 88 current ones.
- **The trips show rides that happened.** A station that is always empty looks quiet in this data. We cannot see
  people who wanted a bike and did not find one.

## What we did

We built a small star schema in BigQuery: one table of trips, with a station table, a calendar and a rider type
table around it. Seven queries in [`etl/`](../etl/README.md) build it, and anyone can run them. The analyses are in [`analyses/`](../analyses/README.md),
one file per question.

## What we found

### 1. Which stations are the busiest?

Queries: [`q1-which-stations-are-busiest.sql`](../analyses/q1-which-stations-are-busiest.sql) and [`q1b-trips-per-dock-2023.sql`](../analyses/q1b-trips-per-dock-2023.sql).

In 2025, **E 21st/Speedway @ PCL** was far ahead: 36,844 trips started there, 9.9% of all starts in the system.

| Rank | Station | Trips started | Trips ended | Share of all starts |
|---|---|---|---|---|
| 1 | E 21st/Speedway @ PCL | 36,844 | 38,498 | 9.9% |
| 2 | Dean Keeton/Speedway | 21,627 | 28,290 | 5.8% |
| 3 | W 26th/Nueces | 22,660 | 19,380 | 6.1% |
| 4 | W 23rd/San Gabriel | 17,442 | 16,958 | 4.7% |
| 5 | W 22nd/Pearl | 16,598 | 12,898 | 4.5% |

The system is concentrated. 83 stations had at least one trip in 2025, and the 11 busiest hold 51.7% of all
starts. Going by their street names, the busiest stations are on or next to the university campus. We could not
confirm that on a map, because the dataset has no location for current stations.

**Busy for their size.** We can only answer this for 2023, in the old system. That year 21st/Speedway @ PCL had
4.06 trip starts per dock per day (22 docks). The next two were 26th/Nueces (2.67, 13 docks) and Dean
Keeton/Speedway (2.48, 19 docks). For the current system, please ask the operator for the dock count of each
station. With that one list, this answer can be redone for 2025 in a few minutes.

### 2. When do people ride, and does it differ by rider type?

Queries: [`q2-when-do-people-ride.sql`](../analyses/q2-when-do-people-ride.sql) and [`q2b-trips-by-hour.sql`](../analyses/q2b-trips-by-hour.sql).

In 2025 the busiest weekday hour was 5 PM (91.5 trips in that hour on an average weekday). Weekdays also have a
morning rise: 30.6 trips at 7 AM and 52.8 at 8 AM. Weekends have no morning rise and no clear peak: every hour
from 1 PM to 5 PM has between 69 and 72 trips.

| Rider group | Trips per weekday | Trips per weekend day | Median trip, weekday | Median trip, weekend |
|---|---|---|---|---|
| Annual member | 727.2 | 465.6 | 5.4 min | 6.5 min |
| Monthly member | 250.1 | 243.9 | 9.8 min | 13.4 min |
| Casual | 86.4 | 200.5 | 21.0 min | 22.7 min |

Annual members use the bikes for short weekday trips. Casual riders make more than twice as many trips on a
weekend day as on a weekday, and their weekday trips are about four times as long as an annual member's. Members
still make most trips on every kind of day. Casual riders are 8.1% of weekday trips and 22.0% of weekend trips.

Two cautions. The rider groups are our own grouping of 17 pass names, and one of them ("Explorer") is our guess.
And we read the hours as local Austin time. The data does not say, but the pattern fits.

### 3. Which stations gain or lose bikes?

Query: [`q3-which-stations-gain-or-lose-bikes.sql`](../analyses/q3-which-stations-gain-or-lose-bikes.sql).

Net is trips that ended at a station minus trips that started there, in 2025.

| Station | Started | Ended | Net for 2025 | Per day |
|---|---|---|---|---|
| Dean Keeton/Speedway | 21,627 | 28,290 | +6,663 | +18.3 |
| E 21st/Speedway @ PCL | 36,844 | 38,498 | +1,654 | +4.5 |
| W 6th/Congress | 5,090 | 6,209 | +1,119 | +3.1 |
| Rainey/Cummings | 10,369 | 9,304 | -1,065 | -2.9 |
| W 26th/Nueces | 22,660 | 19,380 | -3,280 | -9.0 |
| W 22nd/Pearl | 16,598 | 12,898 | -3,700 | -10.1 |

**Dean Keeton/Speedway** collects about 18 more bikes a day than leave it. **W 22nd/Pearl** and **W 26th/Nueces**
lose about 10 and 9 a day. If the van did nothing, those are the stations that would fill up and empty out.

This is the imbalance riders create. The data does not show what the van already does, so it cannot tell you
whether today's schedule is enough.

### 4. How did ridership change?

Queries: [`q4-how-did-ridership-change.sql`](../analyses/q4-how-did-ridership-change.sql) and [`q4b-ridership-by-year.sql`](../analyses/q4b-ridership-by-year.sql).

| Year | Trips | Change from 2023 | Median trip |
|---|---|---|---|
| 2023 | 283,964 | | 8.0 min |
| 2024 | 252,498 | -11.1% | 7.7 min |
| 2025 | 372,389 | +31.1% | 7.1 min |

**Do not read 2024 as a bad year.** The system was switched in July 2024, with no trips for 23 days and a slow
restart (2,035 trips in all of July, against 16,460 in July 2023). The fair comparison is 2025 with 2023:
up 31.1%. 2025 was above 2023 in every month except January (down 7.9%). The largest rise was April, from
27,621 trips to 44,547 (up 61.3%). October was the busiest month in both years (38,727 and 49,972).

## How much to trust it

Seven checks pass ([`validation/README.md`](../validation/README.md)). The ones that matter most for you:

- The trips table we built has exactly the 908,851 trips the public table has for those dates, each one once.
- For every one of those trips, the start and end station in our tables is the station named on the trip in the
  source. This check exists because our first build got it wrong for 47,175 trips in 2023.
- June 2025 counted from our tables equals June 2025 counted straight from the source: 22,492 trips.

What the checks cannot tell you: whether the public table itself is complete, whether the hours are local time,
and whether a station name means the same physical place over time.

## What we would do next

1. Get the current station list from the operator, with dock counts and locations. That unlocks "busy for its
   size" for 2025 and lets us match old and new stations.
2. Look at gain and loss by time of day. A station can be balanced over the whole day and still be empty at 8 AM.
3. Ask the operator for the van's log. Our numbers show where bikes pile up. The log would show what is already done about it.
