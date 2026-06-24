#!/bin/bash

echo "=== Git Install Script ==="

if command -v git &>/dev/null; then
    echo "✅ Git is already installed."
    git --version
    exit 0
fi

echo "Git not found. Installing..."

if command -v apt &>/dev/null; then
    sudo apt update && sudo apt install -y git
elif command -v yum &>/dev/null; then
    sudo yum install -y git
elif command -v dnf &>/dev/null; then
    sudo dnf install -y git
else
    echo "❌ Could not detect a supported package manager (apt/yum/dnf)."
    exit 1
fi

if command -v git &>/dev/null; then
    echo "✅ Git installed successfully."
    git --version
else
    echo "❌ Git installation failed."
    exit 1
fi
