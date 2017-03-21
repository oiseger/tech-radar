#!/bin/bash

# Accept 2 parameters:
# - url of sheet (no default)
# - location to download to (default: ./)

URL=${1}
DATA_DIRECTORY=${2}

if [[ ${URL} == "" ]]
then
  echo "Usage download.sh <URL> <data-directory>"
  exit
fi

MONTH=`date +%m`
YEAR=`date +%Y`

if [[ ${DATA_DIRECTORY} == "" ]]
then
  FILE="data/${YEAR}_${MONTH}.tsv"
  mkdir -p data
else
  FILE="${DATA_DIRECTORY}/data/${YEAR}_${MONTH}.tsv"
  mkdir -p "${DATA_DIRECTORY}/data/"
fi


curl "${URL}" -o "${FILE}"

#remove first row
tail -n +2 "${FILE}" > "$FILE.tmp" && mv "$FILE.tmp" "${FILE}"
