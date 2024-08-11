#!/usr/bin/env bash
set -o errexit
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

: "${year:="$1"}"
: "${year:="$(date -d"now" +'%Y')"}"
#

echo "EXPLOITATION"
echo "======================================================"
ledger bal --no-pager --invert -V -E '^7:[0-578]' '^6:[0-578]' -p "$year"

echo "FINANCIERS"
echo "======================================================"
ledger bal --no-pager --invert -V -E '^7:6' '^6:6' -p "$year"

echo "CONTRIBUTIONS VOLONTAIRES EN NATURE"
echo "======================================================"
ledger bal --no-pager --invert -V -E '^8:6' '^8:7' -p "$year"
