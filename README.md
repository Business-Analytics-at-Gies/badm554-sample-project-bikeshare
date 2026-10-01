# Austin bikeshare: a sample team project

> **SAMPLE PROJECT, fictional team, for BADM 554 learners to read. It is not a template to copy and not an answer key. Your project must use your own dataset and your own decisions.**

Team: Sample Team (Sample Member A, Sample Member B, Sample Member C).

We are answering four questions about Austin's shared bikes for a city transportation planner, from the public
dataset `bigquery-public-data.austin_bikeshare`. Trips from 2023-01-01 to 2025-12-31.

## Run it

```
sh etl/run_all.sh YOUR_PROJECT_ID
```

This runs the seven files in `etl/` in order and prints the row counts. Compare them with `warehouse/README.md`.

## Where things are

- `etl/`: the queries that build the tables
- `analyses/`: questions 1 and 4 so far
- `validation/`: five checks
- `docs/m6-recovery-note.md`: what went wrong in our first build and how we fixed it
- `docs/`: our earlier milestones
