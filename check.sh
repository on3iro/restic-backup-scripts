#!/bin/bash

echo "Checking nextcloud local repo integrity..."
echo "Timestamp: `date`"

source ./restic.conf

restic -r $BUCKET_URL check
