# Oral defense prep

Back to the [project README](../README.md)

The defense is individual, live, with no notes and no AI. This file is what each of us wrote while preparing:
what I built, why the alternative was worse, and two follow-up questions I expect. These are prompts for thinking
and are not scripts. Nobody reads from this in the defense.

## Member A

**What I built.** [`etl/01_stg_trips.sql`](../etl/01_stg_trips.sql), [`etl/06_fact_trip.sql`](../etl/06_fact_trip.sql) and [`etl/run_all.sh`](../etl/run_all.sh). I own the date range and
the grain. I also wrote [question 4](../analyses/q4-how-did-ridership-change.sql) (the trend) and checks [1](../validation/check_1_row_counts_match_source.sql) and [2](../validation/check_2_one_row_per_trip.sql).

**A decision that was mine, and why the alternative was worse.** I kept the fact at one row per trip, and I kept
every trip, including the 153 that are longer than a day and the handful of test rows. The alternative was to
filter them out in the cleaning view. That would have made nicer averages. But then the fact would no longer have
the same number of rows as the source, and my check 1 would have to allow a difference. A check that allows
"about the same" would not have caught 26,693 extra rows as clearly. I chose an exact match and the median.

**My wrong turn.** My first `fact_trip` joined stations on the id. It ran, and it had 935,544 rows for 908,851
trips. I ran one month first (22,180 rows for 22,052 trips) and that is how we saw it early.

**Follow-up questions I expect.**

1. *"Why is the date range in a view, and what happens if the public table adds September 2026 tomorrow?"*
   Nothing changes, because the view stops at the end of 2025. I should be ready to say what would change if the
   public table changed rows inside our range: check 1 would still pass, since it compares with the source as it
   is that day. Our counts in [`warehouse/README.md`](../warehouse/README.md) would then be out of date, and that is how we would notice.
2. *"You join on a station name. What if a name is spelled two ways?"* Then it is two stations in our table. I
   clean whitespace only. I should say plainly that I do not fix spelling, and that check 6 would still pass,
   because it compares with the same cleaned name.

## Member B

**What I built.** [`etl/02_stg_stations.sql`](../etl/02_stg_stations.sql) and [`etl/03_dim_station.sql`](../etl/03_dim_station.sql). Questions [1](../analyses/q1-which-stations-are-busiest.sql) and [3](../analyses/q3-which-stations-gain-or-lose-bikes.sql). [`docs/schema.md`](schema.md).
Checks [4](../validation/check_4_station_dimension.sql) and [6](../validation/check_6_end_station_matches_source.sql).

**A decision that was mine, and why the alternative was worse.** One row per station name per system, with a new
key, and the source id kept only for reference. The alternative was our plan: one row per station id. It was
worse for two reasons I can show with numbers. Four ids have two names, which multiplied trips. And in 2023
the end id on 47,175 trips does not lead to the end name on the trip. The name is never empty and is consistent,
so I trust the name.

**The thing I am least sure of.** The two swapped ids (2498 and 3794). I found them by reading two lists of
names side by side. I am confident about those two. I cannot promise there is no third pair I missed, because no
query finds them. It only affects dock counts for the legacy system.

**Follow-up questions I expect.**

1. *"Why not match the old and new stations? Most names look the same."* The simple rule matches 55 of 88. I would
   have to match 33 by hand with no location to check against. I should be ready for the push: "55 is most of
   them, why not use those?" My answer is that the busiest stations would be compared and the others dropped
   without the planner seeing it, and I would sooner say the comparison is not possible yet.
2. *"Your gain and loss numbers: what would make them wrong?"* An end station recorded wrongly in the source, and
   bikes moved by the van, which are not trips. I should also think about trips that start and end at the same
   station: they add one to both sides and do not change the net.

## Member C

**What I built.** [`etl/04_dim_date.sql`](../etl/04_dim_date.sql), [`etl/05_dim_rider_type.sql`](../etl/05_dim_rider_type.sql), [`etl/07_row_counts.sql`](../etl/07_row_counts.sql). [Question 2](../analyses/q2-when-do-people-ride.sql).
Checks [3](../validation/check_3_no_missing_keys.sql), [5](../validation/check_5_calendar.sql) and [7](../validation/check_7_one_month_matches_source.sql), and [`validation/README.md`](../validation/README.md). I kept the [AI Attribution Log](ai-attribution-log.md).

**A decision that was mine, and why the alternative was worse.** The rider groups. The source has 17 pass names.
The alternative was to report all 17, which is accurate and useless to the planner, or to split only into
"member" and "casual", which hides that annual and monthly members ride differently (median 5.4 minutes against
9.8 on weekdays). I chose five groups and wrote down that they are mine. I also restricted question 2 to 2025,
because the Student group has 145,890 trips in 2023 and none in 2025. I cannot tell from the data whether the
students left or their pass was renamed. Annual member trips rose from 31,872 to 238,223 over the same years,
which fits a renamed pass. I should say it is a guess.

**The day my own check was wrong.** Check 5 expected 23 days with no trips. It found 24. I first assumed I had
broken the calendar. The extra day, 2023-02-01, has no trips in the public table either. My expectation was
wrong and the tables were right. I changed the check to name the 24 days.

**Follow-up questions I expect.**

1. *"How do you know the hours are local time?"* I do not know. I infer it from the pattern, and I say so. I
   should be ready to say what I would do to find out: ask the operator, or compare a known event with a known
   local time.
2. *"All seven checks pass. So the numbers are right?"* No. They show our tables agree with the source and with
   themselves. I should be able to name, for each check, one mistake it would miss. That column is in
   [`validation/README.md`](../validation/README.md) and I wrote it, so I should know it without looking.

## How our AI use changed (each of us answers this for ourselves)

Prompts we used to prepare, with our own [log](ai-attribution-log.md) open:

- What did I ask AI for in Module 2, and what do I ask it for now?
- Name one thing AI gave me that I kept, and one I threw away. How did I decide?
- When did I check an AI answer against the data, and what did the check find?
- How did I get at the data for each task: SQL in the console, the command line, or a chat assistant? Why?
