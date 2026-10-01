# Review 1, from Reviewer Team X

We reviewed the team's Data Product PDF (`docs/m6-data-product-submission.md` is its source). We could not open
the team's repo, and we did not need to.

**Reproducibility: 2 Developing.** Could I rebuild every table from this PDF alone, without asking the team? Not
quite. Every query is there, in order, and each one is short enough to follow. But file 01 writes into a dataset
named `sample_bikeshare_star`, and nothing in the README part of the PDF says I have to make that dataset first.
To be sure, I copied file 01 into my own BigQuery. It stopped with "Not found: Dataset". I then ran only its
SELECT part, without the CREATE line. It returned 908,851 rows, the same as `stg_trips` in your row-count table.
So the queries look fine and the instructions have a hole. Also, the README says to run `sh etl/run_all.sh`, but
that script is not in the PDF, and it never says I need the `bq` tool. Say that, and say what to do if I only
have the console.

**Schema and ETL Quality: 3 Good.** One row per trip is clear and you say why. Joining the station table twice is
easy to follow. One thing confused me. File 03 makes one row per station name per system. So a station that kept
its name across the July 2024 change, like Dean Keeton/Speedway (it is in your id-swap note in file 03 and in your
2025 top list), must be in `dim_station` two times. I worked that out from the SQL, but the PDF should tell me.

**Validation Confidence: 3 Good.** Your row counts match, and the recovery note lists checks for one row per trip
and for clean stations. Good. But from the PDF I cannot tell whether any number is checked against the public
table directly, without going through your own view. Is there one?

**Analysis-to-Question Fit: 3 Good.** Question 1 gives a clear top list. It says "busiest", but your pitch said
"busy for their size". Where is the per-dock answer?

**Documentation and Recovery Evidence: 4 Excellent.** The recovery note is the best part. I could follow both
problems from the tables in it.
