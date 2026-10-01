# Review 2, from Reviewer Team Y

Back to [all reviews](README.md) or the [project README](../../README.md)

We reviewed the team's Data Product PDF ([`docs/m6-data-product-submission.md`](../m6-data-product-submission.md) is its source). We could not open
the team's repo.

**Reproducibility: level 3.** Could I rebuild every table from this PDF alone, without asking the team? Yes, once I
noticed that the dataset has to exist before file 01. Every query is in the PDF, in number order, and the row-count
table gives me something to compare with. Seven files to paste is fine. A note on how much data each step scans
would help anyone who rebuilds it. Nothing in the PDF says.

**Schema and ETL Quality: level 3.** I like that the date range is in one view. But file 04 writes the same two
dates again for the calendar. If someone changes one and forgets the other, what happens? Nothing checks that the
two agree.

Also: are the hours local time or UTC? File 01 takes the hour straight from `start_time`. Your question 2 is all
about hours. If the timestamps are UTC, your rush hour is at the wrong time of day.

**Validation Confidence: level 3.** Check 6 in your recovery note (names match the source) is strong. I would trust
the station joins. I am less sure about dates. None of the checks you list looks at dates at all.

**Analysis-to-Question Fit: level 3.** Question 4 shows months side by side. July 2024 looks like a collapse. The
note about the system change is in a SQL comment. Put it where the planner will see it.

**Documentation and Recovery Evidence: level 3.** Clear. You should be able to compare a station before and after
the system change. Right now I cannot see if "21st/Speedway" grew. Can you match the old and new stations?
