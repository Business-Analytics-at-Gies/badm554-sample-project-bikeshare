# Review 3, from Reviewer Team Z

Back to [all reviews](README.md) or the [project README](../../README.md)

We reviewed the team's Data Product PDF ([`docs/m6-data-product-submission.md`](../m6-data-product-submission.md) is its source). We could not open
the team's repo.

**Reproducibility: 3 Good.** Could I rebuild every table from this PDF alone, without asking the team? Almost.
Reading the README part, I would have stopped at the first step: file 01 writes into `sample_bikeshare_star`, and
nothing says to make it. A teammate pointed that out. After that, every table can be rebuilt from the queries in
the PDF, in order, and the row-count table says what I should get.

**Schema and ETL Quality: 3 Good.** Clean. One thing: nothing in file 01 or file 06 limits `duration_minutes`. If
some trips run longer than a day, an average trip length from this table will be wrong. Did you mean to keep them?

**Validation Confidence: 2 Developing.** The checks named in your recovery note are about counts and keys. They
tell me the tables are well formed. They do not tell me a number is right. Pick one total and tie it to the source.

**Analysis-to-Question Fit: 3 Good.** Both analyses answer the question they state. You only have two of your
four questions so far, which you say yourselves.

**Documentation and Recovery Evidence: 3 Good.** Good recovery note. The rider groups worry me. Who decided that
"Explorer" is a casual pass? File 05 puts it there. If the groups are your own, say so where the planner reads the
answer, and do not only say it in the SQL.
