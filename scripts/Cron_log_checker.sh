#!/bin/bash

echo "Recent cron job activity:"
grep CRON /var/log/syslog | tail -n 20
