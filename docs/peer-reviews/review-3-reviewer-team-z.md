# Review 3, from Reviewer Team Z

**Reproducibility: 6.** Worked with `run_all.sh` once a teammate told me to create the dataset first. Counts
matched.

**Schema and ETL quality: 6.** Clean. One thing: `duration_minutes` has some huge values. I found trips longer
than a day. An average trip length from this table will be wrong. Did you mean to keep them?

**Validation confidence: 4.** Four of your five checks are about counts and keys. They tell me the tables are
well formed. They do not tell me a number is right. Pick one total and tie it to the source.

**Analysis-to-question fit: 6.** Both analyses answer the question they state. You only have two of your four
questions so far, which you say yourselves.

**Documentation and recovery evidence: 5.** Good recovery note. The rider groups worry me. Who decided that
"Explorer" is a casual pass? If the groups are your own, say so where the planner reads the answer, and do not
only say it in the SQL.
