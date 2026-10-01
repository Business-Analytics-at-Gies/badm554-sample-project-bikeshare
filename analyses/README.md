# analyses/

One file per stakeholder question. Each file starts with the question, the answer, the scope, and what would make
the answer wrong. Each query reads only the star tables and brings back a small result (at most 24 rows).

| Question from the planner | File | Short answer | Owner |
|---|---|---|---|
| 1. Which stations are the busiest? | `q1-which-stations-are-busiest.sql` | E 21st/Speedway @ PCL: 36,844 starts in 2025, 9.9% of all starts. The 11 busiest stations hold 51.7% of starts. | Member B |
| 1. And which are busy for their size? | `q1b-trips-per-dock-2023.sql` | Only answerable for 2023. 21st/Speedway @ PCL: 4.06 starts per dock per day. | Member B |
| 2. When do people ride, and does it differ by rider type? | `q2-when-do-people-ride.sql` | Annual members: 727.2 trips per weekday, 465.6 per weekend day. Casual riders: 86.4 and 200.5. | Member C |
| 2. Hour by hour | `q2b-trips-by-hour.sql` | Weekdays peak at 5 PM (91.5 trips). Weekends are flat from 1 PM to 5 PM (69 to 72 trips an hour). | Member C |
| 3. Which stations gain or lose bikes? | `q3-which-stations-gain-or-lose-bikes.sql` | Dean Keeton/Speedway gains about 18.3 bikes a day. W 22nd/Pearl loses about 10.1 a day. | Member B |
| 4. How did ridership change? | `q4-how-did-ridership-change.sql` | 2025 beat 2023 in every month except January. April rose 61.3%. | Member A |
| 4. Year totals | `q4b-ridership-by-year.sql` | 283,964 trips in 2023, 372,389 in 2025, up 31.1%. | Member A |

The write-up that puts these together for the planner is `reports/final-report.md`.

To run one with the command line tool:

```
bq --project_id=YOUR_PROJECT_ID query --use_legacy_sql=false < analyses/q1-which-stations-are-busiest.sql
```

Or paste the file into the BigQuery console.
