#!/usr/bin/env bash
#
# Invoked as S3_BUCKET=<bucket name> backup.sh
#
TARFILE=/tmp/$NFSN_SITE_NAME.tar
LOGFILE=/home/logs/backup.log

tar -cf $TARFILE --exclude home/tmp --exclude home/private/.cache --exclude home/private/.local -C / home 1> $LOGFILE
s3cmd put $TARFILE s3://$S3_BUCKET/ 1>> $LOGFILE 2>&1 | grep -n "Owner groupname not known"
rm $TARFILE 1>> $LOGFILE
