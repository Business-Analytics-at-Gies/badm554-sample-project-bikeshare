# Review 1, from Reviewer Team X

**Reproducibility: 4.** I cloned the repo and ran `sh etl/run_all.sh` with my project id. It stopped at the first
file with "Not found: Dataset". Your README never says I have to make the dataset first. Once I made
`sample_bikeshare_star` by hand, everything ran and my counts matched yours (908,851 in the fact). So the pipeline
is fine and the instructions have a hole. Also, I did not know I needed the `bq` tool installed. Say that, and say
what to do if I only have the console.

**Schema and ETL quality: 6.** One row per trip is clear and you say why. Joining the station table twice is easy
to follow. I was confused that "Dean Keeton/Speedway" is in `dim_station` two times. I worked out that it is once
per system, but the schema file should tell me.

**Validation confidence: 5.** Row counts match and there are no duplicate trips. Good. But every check compares
your tables with your own view. Is there a number checked against the public table directly, without going
through your view?

**Analysis-to-question fit: 5.** Question 1 gives a clear top list. It says "busiest", but your pitch said "busy
for their size". Where is the per-dock answer?

**Documentation and recovery evidence: 6.** The recovery note is the best part. I could follow both problems.
