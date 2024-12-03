#!/bin/bash
SRC_PROJECT=$1
DEST_PROJECT=$2

if [ -z "$2" ]
  then
    echo "usage: $0 <source-project> <destination-project>"
    exit 1
  else
    gcloud config set project ${DEST_PROJECT}

    # for every bucket in the destination project (created by Terraform),
    # sync the data from the equivalent bucket in the source project
    for DEST_BUCKET in $(gsutil ls -p ${DEST_PROJECT}) 
    do 
      SRC_BUCKET=$(echo ${DEST_BUCKET} | sed "s/${DEST_PROJECT}/${SRC_PROJECT}/g")
      echo "running: gsutil rsync -d -r ${SRC_BUCKET} ${DEST_BUCKET}"
      gsutil -m rsync -d -r ${SRC_BUCKET} ${DEST_BUCKET}
    done
fi