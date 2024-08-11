#!/bin/bash
set -o errexit
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

: "${year:="$1"}"
: "${year:="$(date -d"now" +'%Y')"}"
: "${prevyear:="$(date -d"01/01/$year - 1 year" +'%Y')"}"

ledger -f prev.ledger  --forecast \
   "d<=[$year/12/31] and d>=[$prevyear/12/31]"   --invert \
   bal "/^[678]:/" -E -V 

ledger -f prev.ledger --forecast-years 1 \
   --forecast 'd<=[2024/12/31] and d>=[2023/12/31]'  bal \
   -E -V --balance-format '"%A";"%N";%T\n' \
   '/^(6|8:6):/'  | tr -d '€' | tr '.' ',' > budget.csv
ledger -f prev.ledger --forecast-years 1 \
   --forecast 'd<=[2024/12/31] and d>=[2023/12/31]' --invert bal \
   -E -V --balance-format '"%A";"%N";%T\n' \
   '/^(7|8:7):/'  | tr -d '€' | tr '.' ',' >> budget.csv
