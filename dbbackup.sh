#!/usr/bin/env bash
#
# Invoked as HOST=<sql host> USER=<sql user> S3_BUCKET=<s3 bucket> dbbackup.sh
#
LOGFILE=/home/logs/dbbackup.log

mysqldump -h $HOST -u $USER --all-databases > /tmp/$HOST.sql
s3cmd -q put /tmp/$HOST.sql s3://$S3_BUCKET/ 1> $LOGFILE 2>&1 | grep -n "Owner groupname not known"
rm /tmp/$HOST.sql 1>> $LOGFILE
