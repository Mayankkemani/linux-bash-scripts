#!/bin/bash

hosts=(
    "google.com"
    "github.com"
    "8.8.8.8"
)

echo "=== Pinging Multiple Hosts ==="

for host in "${hosts[@]}"; do
    if ping -c 1 -W 2 "$host" &>/dev/null; then
        echo "✅ $host is reachable."
    else
        echo "❌ $host is NOT reachable."
    fi
done
