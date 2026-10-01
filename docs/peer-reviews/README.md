# Reviews we received on the draft data product

Back to the [project README](../../README.md)

Three peer reviews and one mentor review of our Module 6 submission. In the course these arrive through the peer
review tool. We copied them here so the feedback-closure note ([`docs/feedback-closure.md`](../feedback-closure.md)) can point at each item.

In this sample the reviews are written examples, like the team itself. They show the kind of comments a team gets.

| File | From |
|---|---|
| [`review-1-reviewer-team-x.md`](review-1-reviewer-team-x.md) | Reviewer Team X |
| [`review-2-reviewer-team-y.md`](review-2-reviewer-team-y.md) | Reviewer Team Y |
| [`review-3-reviewer-team-z.md`](review-3-reviewer-team-z.md) | Reviewer Team Z |
| [`mentor-review.md`](mentor-review.md) | Our mentor |

**What the peer reviewers saw.** Our team repo is private, so peer reviewers cannot open it. We uploaded one PDF
to the review tool. Its source is [`docs/m6-data-product-submission.md`](../m6-data-product-submission.md): the README rebuild steps, the schema and
grain, every query in `etl/`, the row counts, two analyses and the recovery note. Reproducibility means: could a
reviewer rebuild every table from this PDF alone, without asking us? No reviewer cloned the repo or ran the
build. One reviewer copied one query from the PDF into their own BigQuery and checked one row count against our
table. That step is optional.

**Ratings.** Peer reviewers rated five areas, each on four levels, with a comment for each:

- Reproducibility
- Schema and ETL Quality
- Validation Confidence
- Analysis-to-Question Fit
- Documentation and Recovery Evidence

The levels are level 4 (top), level 3, level 2 and level 1.

**The mentor review is different.** Mentors have access to the team repo. Our mentor cloned it and rebuilt the
tables from it. The mentor also rated the five areas, and that rating counts with the peer ratings.
Our mentor's ratings are not shown here.

Related: [what we did about each comment](../feedback-closure.md) · [the PDF source the reviewers read](../m6-data-product-submission.md) · [the recovery note](../m6-recovery-note.md)
