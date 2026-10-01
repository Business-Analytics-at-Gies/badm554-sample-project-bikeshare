#!/bin/sh
# Rebuild every table from a fresh clone, in order.
#
#   sh etl/run_all.sh YOUR_PROJECT_ID          build everything
#   sh etl/run_all.sh YOUR_PROJECT_ID dry      only show how many bytes each step would scan
#
# The one setting: the dataset that holds our views and tables. No project name is written in any query.
# If you change DATASET here, the script swaps the name into each query as it runs.
DATASET=sample_bikeshare_star

PROJECT="$1"
MODE="$2"
if [ -z "$PROJECT" ]; then
  echo "Usage: sh etl/run_all.sh YOUR_PROJECT_ID [dry]"
  exit 1
fi
cd "$(dirname "$0")/.." || exit 1

# Make the dataset if it is not there yet. Tables in it expire after 30 days; this script rebuilds them.
if [ "$MODE" != "dry" ]; then
  bq --project_id="$PROJECT" --location=US mk --force --dataset \
     --default_table_expiration 2592000 "$PROJECT:$DATASET" || exit 1
fi

for f in etl/0*.sql; do
  echo "== $f"
  if [ "$MODE" = "dry" ]; then
    sed "s/sample_bikeshare_star\./$DATASET./g" "$f" \
      | bq --project_id="$PROJECT" query --use_legacy_sql=false --dry_run || exit 1
  else
    sed "s/sample_bikeshare_star\./$DATASET./g" "$f" \
      | bq --project_id="$PROJECT" query --use_legacy_sql=false || exit 1
  fi
done
echo "Done. Compare the row counts above with warehouse/README.md."
