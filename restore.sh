#!/bin/bash

if [ -z ${RESTORE_FROM_GCS+x} ]; then
  echo "RESTORE_FROM_GCS environment varibale is not set. Aborting restore."
  exit 0
else
  echo "Fetching backup gs://$GCS_BUCKET/$GCS_BUCKET_PATH/$FILE_NAME. Will be avaible in: $RESTORE_SRC_DIR"
fi
if [ -z ${GCS_BUCKET+x} ]; then
  echo "GCS_BUCKET environment varibale is not set. Aborting."
  exit 1
fi
if [ -z ${GCS_BUCKET_PATH+x} ]; then
  echo "GCS_BUCKET_PATH environment varibale is not set. Aborting."
  exit 1
fi
if [ -z ${FILE_NAME+x} ]; then
  echo "FILE_NAME environment varibale is not set. Aborting."
  exit 1
fi
if [ -z ${RESTORE_SRC_DIR+x} ]; then
  echo "RESTORE_SRC_DIR environment varibale is not set. Aborting."
  exit 1
fi

FETCH_DIR=$(mktemp -d)
gsutil cp gs://$GCS_BUCKET/$GCS_BUCKET_PATH/$FILE_NAME $FETCH_DIR
tar -zxf $FETCH_DIR/keycloak-20201028_102517.tar.gz -C $RESTORE_SRC_DIR --strip-components=1
rm -rf $FETCH_DIR
echo "Backup $FILE_NAME is now is availbe in $RESTORE_SRC_DIR"
