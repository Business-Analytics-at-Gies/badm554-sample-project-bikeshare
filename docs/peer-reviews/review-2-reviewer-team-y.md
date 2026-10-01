# Review 2, from Reviewer Team Y

**Reproducibility: 6.** Ran in the console by pasting files 01 to 07 in order, after making the dataset. Same
counts as your warehouse README. It took me about ten minutes. Pasting seven files is fine. A note on how much
data each step scans would have calmed me down before I pressed run.

**Schema and ETL quality: 5.** I like that the date range is in one view. But the calendar table has the same two
dates written again in `04_dim_date.sql`. If someone changes one and forgets the other, what happens? Nothing
checks that the two agree.

Also: are the hours local time or UTC? Your question 2 is all about hours. If the timestamps are UTC, your rush
hour is at the wrong time of day.

**Validation confidence: 5.** Check 6 (names match the source) is strong. I would trust the station joins. I am
less sure about dates. No check looks at dates at all.

**Analysis-to-question fit: 5.** Question 4 shows months side by side. July 2024 looks like a collapse. The note
about the system change is in a SQL comment. Put it where the planner will see it.

**Documentation and recovery evidence: 6.** Clear. You should be able to compare a station before and after the
system change. Right now I cannot see if "21st/Speedway" grew. Can you match the old and new stations?
