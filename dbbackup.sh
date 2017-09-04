#!/usr/bin/env bash
#
# Invoked as HOST=<sql host> USER=<sql user> S3_BUCKET=<s3 bucket> dbbackup.sh
#
LOGFILE=/home/logs/dbbackup.log
BACKUP_FILE=/tmp/$HOST.sql.bz2

mysqldump -h $HOST -u $USER --all-databases | bzip2 > $BACKUP_FILE
s3cmd -q put /tmp/$HOST.sql.bz2 s3://$S3_BUCKET/ 1> $LOGFILE 2>&1 | grep -n "Owner groupname not known"
rm $BACKUP_FILE 1>> $LOGFILE
