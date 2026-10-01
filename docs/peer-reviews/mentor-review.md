# Mentor review

Back to [all reviews](README.md) or the [project README](../../README.md)

I have access to your repo, so I did not work from the PDF alone. I cloned the repo and ran
`sh etl/run_all.sh` with my own project id. It stopped at file 01 with "Not found: Dataset". Once I made
`sample_bikeshare_star` by hand, everything ran and my row counts matched yours (908,851 in the fact).

**Overall.** A working pipeline with honest recovery evidence. The second problem you found (end station ids
that disagree with the names) is the kind of error most teams never see, because the counts look fine. Good.

**What I would fix before the final.**

1. **Rebuild steps.** Two reviewers found the missing dataset step by reading your PDF, and I hit it when I
   rebuilt from the repo. Rewrite the README steps for someone starting from nothing, then have the teammate
   who did not write them follow them exactly.
2. **Rider groups across the system change.** Your Student group will vanish in 2025 if student passes were
   folded into another pass. Check it. If so, a chart of rider groups over three years would tell a false story.
3. **Per-dock.** You promised "busy for their size" in the pitch. If you cannot deliver it for the current
   system, say so plainly, and say what the planner should ask the operator for.
4. **A check on dates.** You fixed a date range and nothing tests it.

**A question for your defense.** Each of you: what is the one thing in your own files that you would not trust
yet, and how would you find out?
