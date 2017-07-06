#!/bin/sh

set -e

DIR_CONFIG=${ARTEMIS_INSTANCE_DIR}/etc
DIR_DATA=${ARTEMIS_INSTANCE_DIR}/data

if [ ! "$(ls -A $DIR_CONFIG)" ] && [ ! "$(ls -A $DIR_DATA)" ]; then
   echo "Empty configuration and data detected. Re-creating artemis instance."
   . /init.sh
else
   echo "'etc' or 'data' directories are populared. Using those."
fi

#/var/lib/artemis/bin/artemis run
