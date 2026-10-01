#!/bin/sh
# Run every validation check, in order. Each prints one row that ends in PASS or FAIL.
# The script ends with an error if any check fails.
#
#   sh validation/run_checks.sh YOUR_PROJECT_ID
#
DATASET=sample_bikeshare_star     # same setting as etl/run_all.sh

PROJECT="$1"
if [ -z "$PROJECT" ]; then
  echo "Usage: sh validation/run_checks.sh YOUR_PROJECT_ID"
  exit 1
fi
cd "$(dirname "$0")/.." || exit 1

failed=0
for f in validation/check_*.sql; do
  out=$(sed "s/sample_bikeshare_star\./$DATASET./g" "$f" \
    | bq --project_id="$PROJECT" query --use_legacy_sql=false) || failed=1
  echo "$out"
  case "$out" in *PASS*) ;; *) failed=1 ;; esac
done
if [ "$failed" -ne 0 ]; then
  echo "At least one check did not pass."
  exit 1
fi
echo "All checks passed."
