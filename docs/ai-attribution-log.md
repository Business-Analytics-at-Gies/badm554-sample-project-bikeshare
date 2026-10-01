# AI Attribution Log

Our log for the whole term. One row per step where AI helped. AI use in the project is allowed with human
revision (AIAS 2). The pitch questions, the rehearsal answers and the oral defense are our own, with no AI.

**About this sample.** This whole sample project, including this log, the documents and the queries, was produced
by an AI agent (Claude) working from the course's instructions, and then reviewed by the instructor. The team
is fictional. The rows below show what a team's log looks like. Rows marked with a star describe
things that really happened while the sample was built. The other rows are examples. Every number is from a
query that was run.

| Module | Who | Tool | What we asked | What we kept | What we changed or rejected, and why |
|---|---|---|---|---|---|
| 2 | Member C | AI chat assistant | "What questions would a city planner ask about bikeshare trip data?" | The idea of asking where bikes pile up (our question 3). | Rejected "predict demand for new stations". We could not see how trip counts would show demand where no station exists. Team Y later said the same. |
| 3 | Member A | AI chat assistant | Explain why July 2024 has so few trips. | Nothing as fact. It suggested a system change or missing data. | We did not accept the explanation until we looked ourselves: from late July 2024 every station id is new (10001 and up) and the bike type has a new value. |
| 4 | Member B | AI chat assistant | "Here is our two-table sketch and four questions. Suggest other star schema designs." | `dim_date` with a weekend flag. `dim_rider_type` with groups. | Rejected separate start and end station tables (same stations twice). Rejected a date-and-hour dimension (26,304 rows to hold one number); the hour stays on the trip, as in our sketch. See the proposal appendix. |
| 4 | Member C | AI chat assistant | Tidy the wording of our column map. | The table layout. | We wrote the transformations ourselves. Its draft said the end station id needed no change. We had seen it is stored as text. |
| 6 ★ | Member B | AI coding assistant | Draft `03_dim_station.sql` from our column map. | The outline of the query. | It used `SELECT DISTINCT` on the station id and name. We accepted that without counting names per id. Four ids have two names, and the fact got 26,693 extra rows. We rewrote the table to be keyed on name and system. Our mistake for not checking. |
| 6 | Member A | AI coding assistant | Draft `06_fact_trip.sql`. | The `LEFT JOIN` pattern, so a missing match shows up as an empty key and the row is kept. | It joined on station ids, as our plan said. After the recovery we changed the joins to system and name. |
| 6 | Member B | AI coding assistant | "Why would an end station id not match its name?" | Nothing. | It guessed at causes. We could not verify any of them, so the recovery note only says what we measured. |
| 6 | Member A | AI coding assistant | Write a shell script that runs the seven files in order. | Most of `run_all.sh`. | We added the one dataset setting at the top, and later (Module 7) the step that makes the dataset and the `dry` option. |
