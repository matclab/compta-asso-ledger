#!/usr/bin/env bash

set -o errexit
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

: "${year:="$1"}"
: "${year:="$(date -d"now" +'%Y')"}"

echo "ACTIF"
ledger bal -E ^2 ^3 -p "$year"

echo "PASSIF"
ledger bal -E ^1  -p "$year"
