# Austin bikeshare: a sample team project

> **SAMPLE PROJECT, fictional team, for BADM 554 learners to read. It is not a template to copy and not an answer key. Your project must use your own dataset and your own decisions.**

Austin bikeshare is not on the course's dataset menu. It was picked for this sample on purpose, so no real team has
it. This is not permission to pick an off-menu dataset: the Project Launch rules still apply to your team.

This repo shows what a finished team project can look like, from Module 1 to Module 8. The team ("Sample Team",
members A, B and C) is made up. The data and every number are real: each one comes from a query that was run on
the public Austin bikeshare dataset in BigQuery.

**How it was made.** The whole sample was produced by an AI agent (Claude) working from the course's project
instructions, in one sitting on the night of September 30 to October 1, 2026. It is to be reviewed by the
instructor before release. The commits were made in one batch, seconds apart. Their order shows the work growing module by
module, with each member committing their own files. Their times mean nothing. The commits also go straight to
`main`. A real team would use a branch and a pull request for each change, as `CONTRIBUTING.md` says.
See `docs/ai-attribution-log.md`.

## The project in four lines

- **Stakeholder:** a senior planner in a city transportation department (a made-up person).
- **Decision:** where to add docks, and where to send the van that moves bikes between stations.
- **Data:** `bigquery-public-data.austin_bikeshare`, trips that started from 2023-01-01 to 2025-12-31 (908,851 trips).
- **Answer:** `reports/final-report.md`.

## Rebuild it from a fresh clone

You need a Google account with BigQuery (the free sandbox is enough). The whole build scans about 0.54 GB.
Nothing is downloaded: the queries read the public dataset and build the tables in your own BigQuery.

**Way 1: the command line.** You need the `bq` tool, which comes with the Google Cloud SDK.

1. Clone this repo and go into the folder.
2. Sign in once: `gcloud auth login`.
3. Build everything: `sh etl/run_all.sh YOUR_PROJECT_ID`
   This makes a dataset named `sample_bikeshare_star` in your project if it is not there, then runs the seven
   files in `etl/` in order. It takes about a minute.
4. The last step prints the row count of every table. Compare with the table below.
5. Run the checks: `sh validation/run_checks.sh YOUR_PROJECT_ID`. Seven rows, each ending in `PASS`.
6. Run any analysis, for example:
   `bq --project_id=YOUR_PROJECT_ID query --use_legacy_sql=false < analyses/q1-which-stations-are-busiest.sql`

Before a later rebuild you can see how much each step would scan, without running anything:
`sh etl/run_all.sh YOUR_PROJECT_ID dry`. This needs the tables from a first build to be there.

**Way 2: the BigQuery console only.**

1. In the console, pick your own project at the top.
2. Make a dataset named `sample_bikeshare_star` (location: US).
3. Open each file in `etl/` in number order, 01 to 07. Paste it into a new query and run it.
4. Compare the output of file 07 with the table below.
5. Paste and run each file in `validation/` (`check_1` to `check_7`), then any file in `analyses/`.

Your project name is never written in a query. Tables are named by dataset only, for example
`sample_bikeshare_star.fact_trip`. If you want another dataset name, change the one line `DATASET=` at the top of
`etl/run_all.sh` and `validation/run_checks.sh`. In the console, use find and replace on each query.

**The counts you should get.**

| Table | Rows |
|---|---|
| `fact_trip` | 908,851 |
| `dim_station` | 171 |
| `dim_date` | 1,096 |
| `dim_rider_type` | 17 |

Running the build a second time gives the same counts. The date range is fixed in `etl/01_stg_trips.sql`, so new
months in the public table do not change them.

**Where this sample's own copy lives.** It was built in the course's BigQuery project, in the dataset
`badm554:sample_bikeshare_star`. Tables and views there expire 30 days after they are built. You do not need access to it:
your rebuild is your own copy.

## What is in the repo

```
README.md                  this file
CONTRIBUTING.md            how we change shared files
etl/                       seven queries that build the tables, and run_all.sh
warehouse/README.md        every table, its grain and its row count
analyses/                  one query file per stakeholder question
validation/                seven checks, and what each cannot see
reports/final-report.md    the write-up for the planner
docs/                      schema, milestones, reviews, logs (see below)
members/                   each member's weekly work (not included in this sample)
```

## The project module by module

| Module | Milestone | File |
|---|---|---|
| 1 | Project Launch: pairing and scoping notes | `docs/m1-scoping-notes.md` |
| 2 | Pitch: outline and speaker notes | `docs/pitch.md` |
| 3 | Draft Proposal, with the paired-read note | `docs/m3-draft-proposal.md` |
| 4 | Final Proposal: questions, schema and grain, ETL plan, labour split, AI checkpoint, feedback memo, appendix | `docs/m4-final-proposal.md` |
| 5 | Analysis Draft: diagram, pipeline sketch, two queries | `docs/m5-analysis-draft.md` |
| 6 | Data Product: the pipeline, and the recovery evidence | `etl/`, `docs/m6-recovery-note.md` |
| 7 | Revision and Rehearsal: reviews received, feedback closure, rehearsal outline | `docs/peer-reviews/`, `docs/feedback-closure.md`, `docs/m7-rehearsal-outline.md` |
| 8 | Final Deliverable | this README, `warehouse/`, `validation/`, `analyses/`, `reports/`, `docs/schema.md`, `docs/ai-attribution-log.md`, `docs/presentation-outline.md` |
| 8 | Oral defense prep, one section per member | `docs/defense-prep.md` |

To see the work grow, read the commit history from the bottom: `git log --reverse --format="%an: %s"`.
The wrong turn in Module 6 is there too, as a first version of two files and then the fix.

## Who owns what

| Member | Files | Questions |
|---|---|---|
| Member A | `etl/01_stg_trips.sql`, `etl/06_fact_trip.sql`, `etl/run_all.sh`, checks 1 and 2 | 4 |
| Member B | `etl/02_stg_stations.sql`, `etl/03_dim_station.sql`, `docs/schema.md`, checks 4 and 6 | 1 and 3 |
| Member C | `etl/04_dim_date.sql`, `etl/05_dim_rider_type.sql`, `etl/07_row_counts.sql`, checks 3, 5 and 7, the AI log | 2 |

Anyone on the team can run the whole build. Each member explains their own files at their defense.

One change from the proposal: there, Member C owned all of `validation/`. During Module 6 we split the checks,
so that each check is written by the person who owns the table it tests. Member C keeps `validation/README.md`
and `validation/run_checks.sh`.

## What this project could not answer

- Trips per dock for the current system. The public station list has no dock counts for current stations.
- How one station changed across the July 2024 system change. Station ids and many names changed.
- Whether a quiet station is quiet because nobody wants a bike there or because it is often empty.
