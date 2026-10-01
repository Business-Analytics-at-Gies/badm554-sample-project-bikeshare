# Module 1: Project Launch

**Team:** Sample Team (Sample Member A, Sample Member B, Sample Member C)

## Our pairing

- **Dataset:** Austin bikeshare trips, `bigquery-public-data.austin_bikeshare` (tables `bikeshare_trips` and
  `bikeshare_stations`).
- **Stakeholder:** a senior planner in a city transportation department. The planner is a made-up person for this
  project.

This pairing was made for this sample. It is not on the course's pairings menu, so no real team has it.

## Scoping notes

**Who the stakeholder is.** In our scenario, the planner looks after the city's shared bike system. The system is
run by an operator, and the city pays for new stations and for the van that moves bikes between stations. The planner is
not a data person and has little time. The planner wants a short answer and one table to back it up.

**What the planner is asking.** Before next spring the planner has to say where the city should add docks and
where the van should go. The question we start from:

> Which stations carry the most riders, when, and where do bikes pile up or run out?

**Why this dataset can answer it.** The trips table has one row for every ride: where it started, where it ended,
when, how long, and what kind of pass the rider had. It holds about 2.9 million trips, from December 2013 to
August 2026. The stations table lists stations with their number of docks. Counting trips by station and by hour
is exactly what the planner needs, and both tables are public, so every one of us can query them from our own
BigQuery account.

**What we are not sure about yet.**

- We have not checked how clean the station names and ids are.
- 2.9 million trips over more than 12 years is more history than the planner needs. We will pick a recent range.
- The trips show rides. They do not show people who wanted a bike and found none. We need to be careful not to
  call a quiet station "low demand".

**Team repo:** this repository.
