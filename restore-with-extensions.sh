#!/bin/bash

function fetchBackup() {
  echo "Fetching backup gs://$GCS_BUCKET/$GCS_BUCKET_PATH/$FILE_NAME. Will be avaible in: $RESTORE_SRC_DIR"
  if [ -z ${GOOGLE_APPLICATION_CREDENTIALS+x} ]; then
    echo "GOOGLE_APPLICATION_CREDENTIALS environment varibale is not set. Aborting."
    exit 1
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
  gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS
  gsutil cp gs://$GCS_BUCKET/$GCS_BUCKET_PATH/$FILE_NAME $FETCH_DIR
  tar -zxf $FETCH_DIR/$FILE_NAME -C $RESTORE_SRC_DIR --strip-components=1
  rm -rf $FETCH_DIR
  echo "Backup $FILE_NAME is now is available in $RESTORE_SRC_DIR"
}

function fetchExtentsions() {
  if [ -z ${GCS_BUCKET_EXTENTIONS+x} ]; then
    echo "GCS_BUCKET environment varibale is not set. Aborting."
    exit 1
  fi
  if [ -z ${GCS_BUCKET_PATH_EXTENTIONS+x} ]; then
    echo "GCS_BUCKET_PATH environment varibale is not set. Aborting."
    exit 1
  fi
  if [ -z ${FILE_NAME_EXTENTIONS+x} ]; then
    echo "FILE_NAME environment varibale is not set. Aborting."
    exit 1
  fi
  if [ -z ${EXTENTIONS_SRC_DIR+x} ]; then
    EXTENTIONS_SRC_DIR=/opt/extensions
  fi
}

if [![ -z ${RESTORE_FROM_GCS+x} ]]; then
  fetchBackup
fi

if [![ -z ${FETCH_EXTENTSIONS_FROM_GCS+x} ]]; then
  fetchExtentsions
fi
