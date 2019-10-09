#!/bin/bash

if [ "${SCHEDULE}" = "**None**" ]; then
  /bin/bash backup.sh
else
  exec go-cron "$SCHEDULE" /bin/bash backup.sh
fi