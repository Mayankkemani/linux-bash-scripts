#!/bin/bash

read -p "Enter website URL to monitor (e.g. https://example.com): " url
read -p "Check interval in seconds (e.g. 60): " interval

echo "=== Monitoring $url every $interval seconds (Ctrl+C to stop) ==="

last_status=""

while true; do
    status_code=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "$url")

    if [ "$status_code" -ge 200 ] && [ "$status_code" -lt 400 ]; then
        current_status="UP"
    else
        current_status="DOWN"
    fi

    if [ "$current_status" != "$last_status" ]; then
        echo "$(date): $url is $current_status (HTTP $status_code)"
        last_status="$current_status"
    fi

    sleep "$interval"
done
