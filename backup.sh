#!/bin/bash
umask 0077

echo "Starting local nextcloud backup\n"
echo "Timestamp: `date`"

set -o pipefail

BASEDIR=$(dirname $0)

source "$BASEDIR/restic.conf"

echo "Enable maintenance mode...\n"
docker exec --user www-data nextcloud_app_1 php occ maintenance:mode --on

# backup the database
docker exec nextcloud_db_1 mysqldump \
	--single-transaction --lock-tables \
	-u root --password=$MYSQL_PW \
	nextcloud \
	| restic -v -r $BUCKET_URL \
	backup \
	--stdin --stdin-filename nextcloud.sql

# backup data directory
restic -v -r $BUCKET_URL \
	backup \
	/mnt/data/nextcloud-data

echo "Disable maintenance mode...\n"
docker exec --user www-data nextcloud_app_1 php occ maintenance:mode --off
