#!/bin/bash
SRC_PROJECT=$1
DEST_PROJECT=$2

if [ -z "$2" ]
  then
    echo "usage: $0 <source-project> <destination-project>"
    exit 1
  else
    gcloud config set project ${DEST_PROJECT}
    # get a list of datasets in the source BQ project
    bq --headless ls ${SRC_PROJECT}:    # first run to discard 'Welcome... ' first run text
    BQOUTPUT="$(bq --headless ls ${SRC_PROJECT}:)"
    if echo "${BQOUTPUT}" | grep -q "BigQuery error"; then
      echo "${BQOUTPUT}"
    else
      for DATASET in $(echo "${BQOUTPUT}" | grep -v 'datasetId\|-')
      do
        # copy each table in the dataset to the destination project/dataset
        echo "running: bq --location=EU mk --dataset ${DEST_PROJECT}:${DATASET}"
        bq --location=EU mk --dataset ${DEST_PROJECT}:${DATASET}
        for TABLE in $(bq ls ${SRC_PROJECT}:${DATASET} | grep TABLE | awk '{print $1}')
        do
          echo "running: bq cp ${SRC_PROJECT}:${DATASET}.${TABLE} ${DEST_PROJECT}:${DATASET}.${TABLE}"
          bq cp ${SRC_PROJECT}:${DATASET}.${TABLE} ${DEST_PROJECT}:${DATASET}.${TABLE}
        done
      done
    fi
fi