#!/bin/bash

echo "Checking nextcloud local repo integrity..."
echo "Timestamp: `date`"

BASEDIR=$(dirname $0)

source "$BASEDIR/restic.conf"

restic -r $BUCKET_URL check
