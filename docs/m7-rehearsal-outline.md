# Module 7: Rehearsal outline

Back to the [project README](../README.md)

Our rehearsal is a recorded video: five minutes on where the project stands, then the hardest questions we expect,
answered on camera without notes or AI. We picked three. This file is the outline we practised from.

## Five-minute check-in

| Time | Who | What |
|---|---|---|
| 0:00 to 0:45 | Member B | The planner, the decision, the four questions. |
| 0:45 to 2:00 | Member A | What is built: four tables in BigQuery, 908,851 trips, rebuilt from seven queries by anyone. The fixed date range. |
| 2:00 to 3:15 | Member B | What went wrong in Module 6: the fact had 26,693 extra rows, and 47,175 trips in 2023 pointed to the wrong end station. How we fixed both. |
| 3:15 to 4:15 | Member C | What is working: seven checks pass. What the checks cannot see. The day our own check was wrong (24 empty days, we expected 23). |
| 4:15 to 5:00 | Member A | What we are still not sure about: local time, the rider groups, and that we cannot compare one station across the system change. |

## The hardest questions we expect

**1. "Your busiest station list is mostly around the university. Is that the system, or is that your data?"**
(Member B) It is in the trips. The top station has 9.9% of all starts in 2025 and the names of the top ten are
streets around the campus. What I cannot show is location: the current stations have no coordinates in this
dataset, so I am reading street names. I would ask the operator for the current station list.

**2. "Are your hours right?"**
(Member C) I believe so and I cannot prove it. The quietest hour is 4 AM and the busiest is 5 PM, which fits
local time. If the timestamps were UTC, the busiest hour would be around noon in Austin. I say this is an
assumption every time I give an hour.

**3. "Why should I trust any number after you told me your first build was wrong?"**
(Member A) Because of how we found it and what we added. The first build was caught by a row count. The second
problem was not visible in any count, so we added a check that compares every trip's station names with the
source, all 908,851 of them. It finds zero differences now. I would trust the station numbers more than I did
before the mistake.

## After watching it back

- Member A ran long on the build. Cut the list of file names.
- We said "the team" too often. In the defense each of us speaks for our own files.
- Nobody could say from memory how many stations have dock counts. It is 71 of 83 legacy stations and none of the
  88 current ones.

Defense slots: each of us has booked one.
