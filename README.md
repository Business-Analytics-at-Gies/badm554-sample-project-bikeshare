# Austin bikeshare: a sample team project

> **SAMPLE PROJECT, fictional team, for BADM 554 learners to read. It is not a template to copy and not an answer key. Your project must use your own dataset and your own decisions.**

Austin bikeshare is not on the course's dataset menu. It was picked for this sample on purpose, so no real team has
it. This is not permission to pick an off-menu dataset: the Project Launch rules still apply to your team.

This repo shows what a finished team project can look like, from Module 1 to Module 8. The team ("Sample Team",
members A, B and C) is made up. The data and every number are real: each one comes from a query that was run on
the public Austin bikeshare dataset in BigQuery.

## Start here

Find the module you are in, in [the table below](#find-what-you-need-this-week), and open that file.
You can do everything in the BigQuery console, with nothing installed. The command line steps are optional.
The folder layout comes from the course [structure repo](https://github.com/Business-Analytics-at-Gies/badm554-project-structure), which has the empty version of every folder and template. The decisions (station keys, number of checks, .sql files
vs a notebook) belong to this dataset and this team, so do not copy them.

**Behind?** Start with [the Module 5 analysis draft](docs/m5-analysis-draft.md), then build one view and one table in the console. Your queries can live in one notebook, or in the `shared/` folder your team repo already has. You do not need this repo's folder layout.

**If you only have five minutes**, read these in this order:

1. [The final report](reports/final-report.md). The answer the team gave the planner, four questions on one page. It shows where the project ends.
2. [The schema](docs/schema.md). The star schema, its grain (one row per trip), and why each choice was made.
3. [One analysis, question 3](analyses/q3-which-stations-gain-or-lose-bikes.sql). One question, one short query, with the answer written at the top.
4. [The rebuild steps](#rebuild-it-from-a-fresh-clone), further down this page. How anyone rebuilds every table, and the row counts to expect.
5. [The Data Product PDF source](docs/m6-data-product-submission.md). The one document the team uploaded for peer review in Module 6.
6. [The recovery note](docs/m6-recovery-note.md). The wrong turn in Module 6, how the team noticed it, and the fix.

### Find what you need this week

| Module | What the course asked for | In this repo | Folder |
|---|---|---|---|
| 1 | Project Launch: pairing and scoping notes | [m1-scoping-notes.md](docs/m1-scoping-notes.md) | `docs/` |
| 2 | Pitch: outline and speaker notes | [pitch.md](docs/pitch.md) | `docs/` |
| 3 | Draft Proposal, with the paired-read note | [m3-draft-proposal.md](docs/m3-draft-proposal.md) | `docs/` |
| 4 | Final Proposal: questions, schema and grain, ETL plan, labour split, AI checkpoint, feedback memo, appendix | [m4-final-proposal.md](docs/m4-final-proposal.md) | `docs/` |
| 5 | Analysis Draft: diagram, pipeline sketch, two queries | [m5-analysis-draft.md](docs/m5-analysis-draft.md) | `docs/` |
| 6 | Data Product: the pipeline, and the recovery evidence | [etl/README.md](etl/README.md), [m6-recovery-note.md](docs/m6-recovery-note.md) | `etl/`, `docs/` |
| 6 | Data Product: the one document uploaded for review (rebuild steps, schema, every query, row counts, two analyses, recovery note) | [m6-data-product-submission.md](docs/m6-data-product-submission.md), or [as a PDF](docs/m6-data-product-submission.pdf) | `docs/` |
| 7 | Revision and Rehearsal: reviews received, feedback closure, rehearsal outline | [the reviews](docs/peer-reviews/README.md), [feedback-closure.md](docs/feedback-closure.md), [m7-rehearsal-outline.md](docs/m7-rehearsal-outline.md) | `docs/peer-reviews/`, `docs/` |
| 8 | Final Deliverable | this README, [warehouse/README.md](warehouse/README.md), [validation/README.md](validation/README.md), [analyses/README.md](analyses/README.md), [final-report.md](reports/final-report.md), [schema.md](docs/schema.md), [ai-attribution-log.md](docs/ai-attribution-log.md), [presentation-outline.md](docs/presentation-outline.md) | several |
| 8, defense | Oral defense prep, one section per member | [defense-prep.md](docs/defense-prep.md) | `docs/` |

Every file in `docs/`, grouped by module, is listed in [docs/README.md](docs/README.md).

## About this sample

**How it was made.** The whole sample was produced by an AI agent (Claude) working from the course's project
instructions, in one sitting on the night of September 30 to October 1, 2026. The instructor reviewed it
before release. The commits were made in one batch, seconds apart. Their order shows the work growing module by
module, with each member committing their own files. Their times mean nothing. The commits also go straight to
`main`. A real team would use a branch and a pull request for each change, as [`CONTRIBUTING.md`](CONTRIBUTING.md) says.
See [`docs/ai-attribution-log.md`](docs/ai-attribution-log.md).

## The project in four lines

- **Stakeholder:** a senior planner in a city transportation department (a made-up person).
- **Decision:** where to add docks, and where to send the van that moves bikes between stations.
- **Data:** `bigquery-public-data.austin_bikeshare`, trips that started from 2023-01-01 to 2025-12-31 (908,851 trips).
- **Answer:** [`reports/final-report.md`](reports/final-report.md).

## Rebuild it from a fresh clone

You need a Google account with BigQuery (the free sandbox is enough). The whole build scans about 0.54 GB.
Nothing is downloaded: the queries read the public dataset and build the tables in your own BigQuery.

**Way 1: the BigQuery console only.** Nothing to install.

1. In the console, pick your own project. Your project ID is shown in the project picker at the top of the BigQuery console.
2. Make the dataset. In Explorer, click the three dots next to your project, then Create dataset. ID `sample_bikeshare_star`, location US (multi-region).
3. Open each file in `etl/` in number order, 01 to 07. Paste it into a new query and run it.
4. Compare the output of file 07 with the table below.
5. Paste and run each file in `validation/` (`check_1` to `check_7`), then any file in `analyses/`.

**Way 2: the command line (optional).** You need the `bq` tool, which comes with the Google Cloud SDK. The scripts
run with `sh`, so on Windows use Git Bash or WSL.

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
| `stg_trips` (view) | 908,851 |
| `stg_stations` (view) | 101 |

Running the build a second time gives the same counts. The date range is fixed in [`etl/01_stg_trips.sql`](etl/01_stg_trips.sql), so new
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
docs/                      schema, milestones, reviews, logs (index: docs/README.md)
members/                   each member's weekly work (not included in this sample)
```

Each folder has its own README that says what is in it: [etl](etl/README.md), [warehouse](warehouse/README.md),
[analyses](analyses/README.md), [validation](validation/README.md), [peer reviews](docs/peer-reviews/README.md) and
[members](members/README.md).

## The project module by module

The table of milestones, with a link to each file, is [Find what you need this week](#find-what-you-need-this-week), near the top of this page.

To see the work grow, read the commit history from the bottom: `git log --reverse --format="%an: %s"`.
The wrong turn in Module 6 is there too, as a first version of two files and then the fix.

## Who owns what

| Member | Files | Questions |
|---|---|---|
| Member A | [`etl/01_stg_trips.sql`](etl/01_stg_trips.sql), [`etl/06_fact_trip.sql`](etl/06_fact_trip.sql), [`etl/run_all.sh`](etl/run_all.sh), checks [1](validation/check_1_row_counts_match_source.sql) and [2](validation/check_2_one_row_per_trip.sql) | [4](analyses/q4-how-did-ridership-change.sql) |
| Member B | [`etl/02_stg_stations.sql`](etl/02_stg_stations.sql), [`etl/03_dim_station.sql`](etl/03_dim_station.sql), [`docs/schema.md`](docs/schema.md), checks [4](validation/check_4_station_dimension.sql) and [6](validation/check_6_end_station_matches_source.sql) | [1](analyses/q1-which-stations-are-busiest.sql) and [3](analyses/q3-which-stations-gain-or-lose-bikes.sql) |
| Member C | [`etl/04_dim_date.sql`](etl/04_dim_date.sql), [`etl/05_dim_rider_type.sql`](etl/05_dim_rider_type.sql), [`etl/07_row_counts.sql`](etl/07_row_counts.sql), checks [3](validation/check_3_no_missing_keys.sql), [5](validation/check_5_calendar.sql) and [7](validation/check_7_one_month_matches_source.sql), [the AI log](docs/ai-attribution-log.md) | [2](analyses/q2-when-do-people-ride.sql) |

Anyone on the team can run the whole build. Each member explains their own files at their defense ([defense prep](docs/defense-prep.md)).

One change from the proposal: there, Member C owned all of `validation/`. During Module 6 we split the checks,
so that each check is written by the person who owns the table it tests. Member C keeps [`validation/README.md`](validation/README.md)
and [`validation/run_checks.sh`](validation/run_checks.sh).

## What this project could not answer

- Trips per dock for the current system. The public station list has no dock counts for current stations.
- How one station changed across the July 2024 system change. Station ids and many names changed.
- Whether a quiet station is quiet because nobody wants a bike there or because it is often empty.
