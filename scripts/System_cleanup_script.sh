#!/bin/bash

echo "=== System Cleanup Script ==="

if command -v apt &>/dev/null; then
    echo "Cleaning up with apt..."
    sudo apt autoremove -y
    sudo apt autoclean
    sudo apt clean
elif command -v dnf &>/dev/null; then
    echo "Cleaning up with dnf..."
    sudo dnf autoremove -y
    sudo dnf clean all
elif command -v yum &>/dev/null; then
    echo "Cleaning up with yum..."
    sudo yum autoremove -y
    sudo yum clean all
else
    echo "❌ Could not detect a supported package manager."
    exit 1
fi

echo "✅ Package cleanup complete."
