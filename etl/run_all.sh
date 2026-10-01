#!/bin/sh
# Rebuild every table from a fresh clone, in order.
#
#   sh etl/run_all.sh YOUR_PROJECT_ID
#
# The one setting: the dataset that holds our views and tables. No project name is written in any query.
# If you change DATASET here, the script swaps the name into each query as it runs.
DATASET=sample_bikeshare_star

PROJECT="$1"
if [ -z "$PROJECT" ]; then
  echo "Usage: sh etl/run_all.sh YOUR_PROJECT_ID"
  exit 1
fi
cd "$(dirname "$0")/.." || exit 1

for f in etl/0*.sql; do
  echo "== $f"
  sed "s/sample_bikeshare_star\./$DATASET./g" "$f" \
    | bq --project_id="$PROJECT" query --use_legacy_sql=false || exit 1
done
echo "Done. Compare the row counts above with warehouse/README.md."
