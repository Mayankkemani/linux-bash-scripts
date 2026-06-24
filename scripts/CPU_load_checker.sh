#!/bin/bash

echo "CPU load average:"
uptime | awk -F'load average:' '{print $2}'
