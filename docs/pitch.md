# Module 2: Project Pitch

The pitch itself is a five-minute video with all three of us in it. This file is our outline and speaker notes.
Path: recorded, with our own two to three minutes of questions at the end.

## Outline (5 minutes)

| Time | Who | What we say |
|---|---|---|
| 0:00 to 0:45 | Member A | Who the planner is and the decision they face: where to add docks and where to send the van before next spring. |
| 0:45 to 2:30 | Member B | Our four questions, one sentence each, and what the planner would do with each answer. |
| 2:30 to 3:45 | Member C | Why this dataset: one row per ride, with start, end, time and pass type. What it cannot tell us. |
| 3:45 to 5:00 | Member A | What we will build (a small star schema in BigQuery) and what we will hand over (one page with four answers). |

## Speaker notes

**Member A, opening.** "Our stakeholder is a planner at a city transportation department. In our scenario the city pays for new
bike stations and for the van that moves bikes around. Before spring the planner has to decide where more docks go
and where the van should be at what time. Today that decision is made from complaints and from what the operator
says. We want to give the planner counts."

**Member B, the questions.**

1. Which stations are the busiest, and which are busy for their size? The planner adds docks where each dock is
   used the most.
2. When do people ride, by hour and by weekday or weekend, and is it different for members and for casual riders?
   The van schedule and the staffing follow from this.
3. Which stations end the day with more bikes than they started with, and which with fewer? That is the van's
   to-do list.
4. How has ridership changed over the last three years? The planner needs to know if the system is growing before
   asking for money.

**Member C, the dataset.** "Every ride is one row: start station, end station, start time, minutes, pass type.
That is exactly the level our questions need. No other public source has the rides themselves. Two limits. First,
we only see rides that happened. If a station was empty and someone walked away, the data does not know. Second,
the stations table may be out of date. We will check it before we promise the per-dock answer."

**Member A, close.** "We will build one trips table with a station, a date and a rider type table around it, in
BigQuery, from queries in our repo. Anyone can rebuild it. The planner gets one page: four questions, four
answers, each with a number."

## Questions we expect, and who answers

- "Busy stations are obvious. What will I learn that I do not already know?" (Member B) We expect the per-dock view
  and the gain-or-lose view to differ from the plain busy list. If they do not, we will say so.
- "A quiet station might be quiet because it is always empty. Can you tell?" (Member C) No. We will say that
  clearly and not call it low demand.
- "Why three years and not all twelve?" (Member A) The system today is not the system of 2014. Recent years
  describe the decision better. We will fix the range and keep it.

Answers in the recording are our own. We did not use AI during the questions.
