#!/bin/bash
umask 0077

echo "Starting nextcloud local backup cleanup"
echo "Timestamp `date`"

set -o pipefail

source restic.conf

restic -r $BUCKET_URL snapshots

restic -r $BUCKET_URL forget \
	--keep-daily 3 \
	--keep-monthly 2 \
	--keep-yearly 2 \
	--prune

