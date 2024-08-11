#!/usr/bin/env bash
set -o errexit
set -o pipefail
shopt -s lastpipe
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

: "${ok:="0"}"
: "${year:="$1"}"
: "${year:="$(date -d"now" +'%Y')"}"
: "${prevyear:="$(date -d"01/01/$year - 1 year" +'%Y')"}"
: "${nowlastyear:="$(date -d"now - 1 year" +'%Y%m%d')"}"

nbpayed=0
mapfile -t  people < <(j2 <(echo -e "{% for k,p in people.items() %}{{ p.prenom }} {{ p.nom }}\n{% endfor %}") users.yaml)

#echo "${people[@]}"

ledger csv 7:5:8:1 -b "$prevyear" --by-payee --date-format "%Y%m%d" | while IFS="," read -r lastdate _ payee _; do
   lastdate=$(echo "$lastdate" | tr -d '"')
   payee=$(echo "$payee" | tr -d '"')
   if [[ "$lastdate" < "$nowlastyear" ]]
   then
      if echo "${people[@]}" | grep -q "$payee"
      then
	 echo "$payee doit payer sa cotisation (dernier paiement le $lastdate)"
      else
	 echo "$payee n'est plus ou pas un membre"
      fi
   else
      [[ $ok == 1 ]] && echo "$payee est à jour ($lastdate)" || true
      nbpayed=$(( $nbpayed+1 ))
   fi
done

payees=$(ledger csv 7:5:8:1 --by-payee --format="%(payee)\n")

for p in "${people[@]}"
do
   if ! grep -q "$p" <(echo "$payees")
   then
	 echo "$p doit payer sa cotisation (n'a jamais payé)"
   fi
done
echo "$nbpayed/${#people[@]} cotisations payées"
