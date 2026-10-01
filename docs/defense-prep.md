# Oral defense prep

The defense is individual, live, with no notes and no AI. This file is what each of us wrote while preparing:
what I built, why the alternative was worse, and two follow-up questions I expect. These are prompts for thinking
and are not scripts. Nobody reads from this in the defense.

## Member A

**What I built.** `etl/01_stg_trips.sql`, `etl/06_fact_trip.sql` and `etl/run_all.sh`. I own the date range and
the grain. I also wrote question 4 (the trend) and checks 1 and 2.

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
   is that day. Our counts in `warehouse/README.md` would then be out of date, and that is how we would notice.
2. *"You join on a station name. What if a name is spelled two ways?"* Then it is two stations in our table. I
   clean whitespace only. I should say plainly that I do not fix spelling, and that check 6 would still pass,
   because it compares with the same cleaned name.

## Member B

**What I built.** `etl/02_stg_stations.sql` and `etl/03_dim_station.sql`. Questions 1 and 3. `docs/schema.md`.
Checks 4 and 6.

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
