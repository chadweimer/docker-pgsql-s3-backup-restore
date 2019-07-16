#! /bin/sh

set -e

if [ "${S3_S3V4}" = "yes" ]; then
    aws configure set default.s3.signature_version s3v4
fi

if [ "${SCHEDULE}" = "**None**" ]; then
  sh backup.sh
else
  echo "$SCHEDULE /bin/sh $(pwd)/backup.sh" > crontab-fragment.txt
  crontab -l | cat - crontab-fragment.txt > crontab.txt && crontab crontab.txt
  crond -f
fi
