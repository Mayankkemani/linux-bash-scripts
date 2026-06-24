#!/bin/bash

echo "=========================================="
echo "         SYSTEM HEALTH REPORT"
echo "         $(date)"
echo "=========================================="

# ---- Uptime ----
echo ""
echo "--- Uptime ---"
echo "Up since: $(uptime -s)"
echo "Uptime: $(uptime -p)"

# ---- CPU ----
echo ""
echo "--- CPU ---"
cores=$(nproc)
load=$(uptime | awk -F'load average:' '{print $2}' | awk -F',' '{print $1}' | tr -d ' ')
echo "CPU cores: $cores"
echo "Load average (1, 5, 15 min):$(uptime | awk -F'load average:' '{print $2}')"

high_load=$(awk -v l="$load" -v c="$cores" 'BEGIN { print (l > c) ? "1" : "0" }')
if [ "$high_load" -eq 1 ]; then
    echo "⚠️  WARNING: Load average exceeds CPU core count!"
else
    echo "OK: CPU load is within normal range."
fi

# ---- Memory ----
echo ""
echo "--- Memory ---"
total=$(free -m | awk '/Mem:/ {print $2}')
used=$(free -m | awk '/Mem:/ {print $3}')
mem_percent=$((used * 100 / total))
echo "Used: ${used}MB / ${total}MB (${mem_percent}%)"

if [ "$mem_percent" -ge 80 ]; then
    echo "⚠️  WARNING: Memory usage above 80%!"
else
    echo "OK: Memory usage is within normal range."
fi

# ---- Disk ----
echo ""
echo "--- Disk ---"
df -h --output=target,pcent | tail -n +2 | while read -r mount usage; do
    percent=$(echo "$usage" | tr -d '%')
    if [ "$percent" -ge 80 ]; then
        echo "⚠️  WARNING: $mount is at $usage usage!"
    else
        echo "OK: $mount is at $usage usage."
    fi
done

echo ""
echo "=========================================="
echo "         END OF REPORT"
echo "=========================================="
