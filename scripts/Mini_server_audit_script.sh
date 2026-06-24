#!/bin/bash

echo "=========================================="
echo "         MINI SERVER AUDIT REPORT"
echo "         $(date)"
echo "=========================================="

# ---- System Info ----
echo ""
echo "--- System Info ---"
echo "Hostname: $(hostname)"
echo "OS: $(. /etc/os-release && echo "$PRETTY_NAME" 2>/dev/null || uname -s)"
echo "Kernel: $(uname -r)"
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

# ---- Failed Services ----
echo ""
echo "--- Failed Services ---"
failed=$(systemctl --failed --no-legend 2>/dev/null)
if [ -z "$failed" ]; then
    echo "✅ No failed services."
else
    echo "❌ Failed services found:"
    echo "$failed"
fi

# ---- Key Services Status ----
echo ""
echo "--- Key Services ---"
for service in nginx ssh sshd mysql docker; do
    if systemctl list-units --full -all 2>/dev/null | grep -q "${service}.service"; then
        if systemctl is-active --quiet "$service"; then
            echo "✅ $service is running."
        else
            echo "❌ $service is installed but NOT running."
        fi
    fi
done

# ---- Network ----
echo ""
echo "--- Network ---"
if ping -c 1 -W 2 8.8.8.8 &>/dev/null; then
    echo "✅ Internet connectivity: OK"
else
    echo "❌ Internet connectivity: FAILED"
fi

echo "Listening ports (top 10):"
sudo ss -tulpn 2>/dev/null | head -n 11

# ---- Logged-in Users ----
echo ""
echo "--- Logged-in Users ---"
who

# ---- Last 5 logins ----
echo ""
echo "--- Last 5 Logins ---"
last -n 5

echo ""
echo "=========================================="
echo "         END OF AUDIT REPORT"
echo "=========================================="
