#!/bin/bash
SNAPSHOT=2022-09-15T15:05:37_73896/2022-09-15T15:05:37_73896.overall_export_metadata
SRC_LOCATION=gs://**add_source_bucket_here**/${SNAPSHOT}
SRC_BUCKET=gs://**add_source_bucket_here**
DEST_PROJECT=$1

if [ -z "$1" ]
  then
    echo "usage: $0 <destination-project>"
    exit 1
  else
    gcloud config set project ${DEST_PROJECT}
    # copy seed data from demo into project specific bucket and import
    echo "running: gsutil mb -c regional -l europe-west2 -p ${DEST_PROJECT} gs://${DEST_PROJECT}-seed-data"
    gsutil mb -c regional -l europe-west2 -p ${DEST_PROJECT} gs://${DEST_PROJECT}-seed-data
    echo "running: gsutil -m rsync -d -r ${SRC_BUCKET} gs://${DEST_PROJECT}-seed-data"
    gsutil -m rsync -d -r ${SRC_BUCKET} gs://${DEST_PROJECT}-seed-data
    echo "running: gcloud datastore import ${SRC_LOCATION}"
    gcloud datastore import gs://${DEST_PROJECT}-seed-data/${SNAPSHOT}
    echo "running: gcloud datastore indexes create index.yaml"
    gcloud datastore indexes create index.yaml
fi
