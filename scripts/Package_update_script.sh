#!/bin/bash

echo "=== Package Update Script ==="

if command -v apt &>/dev/null; then
    echo "Detected apt (Debian/Ubuntu). Updating..."
    sudo apt update && sudo apt upgrade -y
elif command -v dnf &>/dev/null; then
    echo "Detected dnf (Fedora/RHEL 8+). Updating..."
    sudo dnf upgrade -y
elif command -v yum &>/dev/null; then
    echo "Detected yum (CentOS/RHEL 7). Updating..."
    sudo yum update -y
else
    echo "❌ Could not detect a supported package manager (apt/yum/dnf)."
    exit 1
fi

echo "✅ Package update complete."
