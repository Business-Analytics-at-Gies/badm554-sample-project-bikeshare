# Module 8: Presentation outline (12 to 15 minutes)

Back to the [project README](../README.md)

All three of us present. The presentation says what we built, what we found and what is next. The detail is in
the repo ([Start here](../README.md#start-here)).

| Time | Who | Slide | What we say |
|---|---|---|---|
| 0:00 to 1:30 | Member B | The planner and the decision | Who the planner is. Docks and the van, before spring. Four questions. |
| 1:30 to 3:00 | Member A | The data | Two public tables. 908,851 trips, 2023 to 2025, a fixed range. The July 2024 system change, shown as one chart of trips per month. |
| 3:00 to 5:00 | Member B | The schema | The diagram. One row per trip, and why. The station table joined twice. Why a station appears once per system. |
| 5:00 to 7:00 | Member A | The build, and the wrong turn | Seven queries, views then tables, anyone can run them. The first build: 935,544 rows for 908,851 trips. The second problem no count could see: 47,175 wrong end stations in 2023. The fix. |
| 7:00 to 8:30 | Member C | How we check it | Seven checks, one line each. The check that failed because our expectation was wrong (24 empty days). What the checks cannot see. |
| 8:30 to 12:00 | B, C, B, A | The four answers | One slide per question, one table each, taken from the [report](../reports/final-report.md). B: busiest stations, 9.9% at one station, 51.7% at eleven. C: weekday members, weekend casual riders. B: Dean Keeton/Speedway gains 18.3 bikes a day. A: up 31.1% from 2023 to 2025, and why 2024 is not a bad year. |
| 12:00 to 13:30 | Member C | What we could not answer | Per dock for the current system. One station across the change. Whether the van already handles it. What to ask the operator for. |
| 13:30 to 14:30 | Member A | What is next, and how to rebuild it | The three next steps from the [report](../reports/final-report.md#what-we-would-do-next). The repo: clone, one command, same counts. |

## Rules we set ourselves

- One number per sentence. Say the year with every number.
- Every slide with a station name says which system.
- No slide of SQL. If someone asks, we open the file in the repo.
- A timer on the table. We rehearsed at 13 minutes 40 seconds.
