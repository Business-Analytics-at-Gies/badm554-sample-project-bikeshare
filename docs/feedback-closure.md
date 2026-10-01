# Feedback closure

Back to the [project README](../README.md)

Every piece of feedback we received on the draft data product, one row each: what changed, or why nothing changed.
The reviews are in [`docs/peer-reviews/`](peer-reviews/README.md). Written in Module 7. Updated in Module 8, when the report was finished.

The three peer reviewers read the one PDF we uploaded ([`docs/m6-data-product-submission.md`](m6-data-product-submission.md)). They could not open
our repo. Our mentor rebuilt the tables from the repo. The peer ratings, on four levels (level 4 is the top, then level 3, level 2 and
level 1):

| Area | [Reviewer Team X](peer-reviews/review-1-reviewer-team-x.md) | [Reviewer Team Y](peer-reviews/review-2-reviewer-team-y.md) | [Reviewer Team Z](peer-reviews/review-3-reviewer-team-z.md) |
|---|---|---|---|
| Reproducibility | level 2 | level 3 | level 3 |
| Schema and ETL Quality | level 3 | level 3 | level 3 |
| Validation Confidence | level 3 | level 3 | level 2 |
| Analysis-to-Question Fit | level 3 | level 3 | level 3 |
| Documentation and Recovery Evidence | level 4 | level 3 | level 3 |

The two level 2 ratings are items 1 and 4 below. The table answers every comment, not only the low ratings.

| # | Who, and what they said | What we did | Why |
|---|---|---|---|
| 1 | [Reviewer Team X](peer-reviews/review-1-reviewer-team-x.md), [Reviewer Team Z](peer-reviews/review-3-reviewer-team-z.md), [mentor](peer-reviews/mentor-review.md): the README in our PDF never says to make the dataset before file 01. The mentor's rebuild from the repo stopped with "Not found: Dataset". | Changed. [`etl/run_all.sh`](../etl/run_all.sh) now makes the dataset if it is missing. The [README](../README.md#rebuild-it-from-a-fresh-clone) has numbered rebuild steps, including the console way. Member C, who did not write them, followed them from a fresh clone and got the same counts. | Two reviewers found it by reading the PDF, and the mentor hit it in a real rebuild. We had each made the dataset weeks ago and forgot it was a step. |
| 2 | [Reviewer Team X](peer-reviews/review-1-reviewer-team-x.md): say that the `bq` tool is needed, and what to do with only the console. | Changed. The README lists what you need and gives both ways. | Fair. We assumed our own setup. |
| 3 | [Reviewer Team X](peer-reviews/review-1-reviewer-team-x.md): "Dean Keeton/Speedway" must be in `dim_station` twice, and the PDF does not say why. | Changed. [`docs/schema.md`](schema.md) now has a section on why a station can appear twice. | It is on purpose (once per system), and a reader should not have to work that out. |
| 4 | [Reviewer Team X](peer-reviews/review-1-reviewer-team-x.md), [Reviewer Team Z](peer-reviews/review-3-reviewer-team-z.md): no number is checked against the public table directly. | Changed. Added [check 7](../validation/check_7_one_month_matches_source.sql): June 2025 trips and minutes, counted from the star and counted straight from the public table. Both give 22,492 trips. | Checks 1 and 6 already read the public table, but nothing in the PDF told the reviewer so. The [validation README](../validation/README.md) now says what each check compares with. Check 1 covers the whole range only. One month through `dim_date` also tests the date key. |
| 5 | [Reviewer Team X](peer-reviews/review-1-reviewer-team-x.md), [mentor](peer-reviews/mentor-review.md): where is the per-dock answer you promised? | Changed in part. Added [`analyses/q1b-trips-per-dock-2023.sql`](../analyses/q1b-trips-per-dock-2023.sql), for the legacy system in 2023. The report says plainly that it cannot be done for the current system and what to ask the operator for. | The city list has dock counts for 71 legacy stations and for none of the 88 current ones. Without dock counts there is nothing to divide by. |
| 6 | [Reviewer Team Y](peer-reviews/review-2-reviewer-team-y.md): the date range is written in two files and nothing checks they agree. | Changed. Added [check 5](../validation/check_5_calendar.sql), which tests that the calendar and the trips cover the same days. We left the dates where they are: in the two build files, and in checks 1 and 5 that test them. | Check 5 is the cheaper fix. It also found something: 24 days with no trips, when we expected 23. See [`validation/README.md`](../validation/README.md). |
| 7 | [Reviewer Team Y](peer-reviews/review-2-reviewer-team-y.md): are the hours local time or UTC? | No change to the data. We wrote the assumption into [`docs/schema.md`](schema.md) and into each hour answer. | The source does not say. The pattern fits local time (quietest at 4 AM, busiest at 5 PM). We could not confirm it, so we say it is an assumption. |
| 8 | [Reviewer Team Y](peer-reviews/review-2-reviewer-team-y.md): July 2024 looks like a collapse and the note is hidden in a SQL comment. | Changed. The [report's answer to question 4](../reports/final-report.md#4-how-did-ridership-change) leads with the system change, and the header of the analysis file says it too. | They are right that a planner does not read SQL comments. |
| 9 | [Reviewer Team Y](peer-reviews/review-2-reviewer-team-y.md): match the old and new stations so a station can be compared across the change. | **Not done.** | We tried the simple rule (drop the leading E, W, N or S from the new name). It matches 55 of 88 current stations. The other 33 need matching by hand, and we have no map location for current stations to check a match against. A wrong match would be worse than no match. We compare the whole system across years, and stations inside one system. |
| 10 | [Reviewer Team Z](peer-reviews/review-3-reviewer-team-z.md): trips longer than a day will wreck an average. Did you mean to keep them? | Kept the rows. We report the median and say so in [`docs/schema.md`](schema.md). | 153 trips are longer than a day. Removing them would make the fact differ from the source, and then check 1 could not be exact. The median is not moved by them. |
| 11 | [Reviewer Team Z](peer-reviews/review-3-reviewer-team-z.md): who decided "Explorer" is a casual pass? Say that the groups are your own where the planner reads it. | Changed. The [report](../reports/final-report.md) and [`docs/schema.md`](schema.md) say the groups are ours and that "Explorer" is our guess. | We did not find a definition. We grouped it by its long trips. That is a guess and should be labelled as one. |
| 12 | [Mentor](peer-reviews/mentor-review.md): your Student group will vanish in 2025. Check it. | Checked, and it does: 145,890 Student trips in 2023, 73,834 in 2024, 0 in 2025. Question 2 now uses 2025 only, and we do not show rider groups across years. | A three-year chart of rider groups would have shown students leaving the system. We cannot tell from the data whether they left. Annual member trips rose from 31,872 in 2023 to 238,223 in 2025, which fits a student pass that was folded into the annual pass. |
| 13 | [Mentor](peer-reviews/mentor-review.md): a check on dates. | Same as item 6. | |
| 14 | [Reviewer Team Y](peer-reviews/review-2-reviewer-team-y.md): a note on how much data each step scans. | Changed. `sh etl/run_all.sh YOUR_PROJECT_ID dry` prints the bytes for each step without running it. The whole build is about 0.54 GB. | Cheap to add, and it is a good habit before pressing run. |
| 15 | [Reviewer Team Z](peer-reviews/review-3-reviewer-team-z.md): you only have two of your four questions so far. | Changed. Questions 2 and 3 are now in [`analyses/`](../analyses/README.md). | This was our plan from the proposal. It is listed here so no comment goes unanswered. |
| 16 | [Mentor](peer-reviews/mentor-review.md): each of you, what in your own files would you not trust yet? | No change to the repo. Each of us wrote an answer while preparing for the [defense](defense-prep.md). | It is a question for each person, so the answers are ours one by one. |

## What we did not take, in one place

Item 9 (matching stations across the two systems) and half of item 5 (per-dock for the current system). Both for
the same reason: the data to do it properly is not in the public dataset. A reader could not tell our guess from a measured number.
