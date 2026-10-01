# Changing shared files

Back to the [project README](README.md)

`members/<your-folder>/` is yours alone. Everything else is shared, so two of us can change the same file at once.
This is how we change shared files.

1. **Pull first.** `git pull`.
2. **Make a branch** named for the change: `git switch -c fix-station-join`.
3. **Change only your own files where you can.** Each file in [`etl/`](etl/README.md) and [`validation/`](validation/README.md) names its owner at the top.
   If you need a change in someone else's file, ask them, or say so in the pull request.
4. **Commit under your own name.** Start the message with the module, for example `M6: fix dim_station`.
5. **Push and open a pull request.** Say in one or two sentences what changed and why.
6. **A teammate reviews and merges it.** Then everyone pulls.

After any change to a file in `etl/`, rebuild and run the checks before you open the pull request:

```
sh etl/run_all.sh YOUR_PROJECT_ID
sh validation/run_checks.sh YOUR_PROJECT_ID
```

If the row counts differ from [`warehouse/README.md`](warehouse/README.md), say so in the pull request. Do not edit the counts to match.
