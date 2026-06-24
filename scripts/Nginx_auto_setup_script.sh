#!/bin/bash

echo "=== Nginx Auto Setup ==="

# Detect package manager
if command -v apt &>/dev/null; then
    pkg_manager="apt"
elif command -v yum &>/dev/null; then
    pkg_manager="yum"
elif command -v dnf &>/dev/null; then
    pkg_manager="dnf"
else
    echo "❌ Could not detect a supported package manager (apt/yum/dnf)."
    exit 1
fi

echo "Detected package manager: $pkg_manager"

# Install Nginx if not already installed
if command -v nginx &>/dev/null; then
    echo "✅ Nginx is already installed."
else
    echo "Installing Nginx..."
    case "$pkg_manager" in
        apt)
            sudo apt update && sudo apt install -y nginx
            ;;
        yum)
            sudo yum install -y nginx
            ;;
        dnf)
            sudo dnf install -y nginx
            ;;
    esac
fi

# Enable and start Nginx
echo "Enabling and starting Nginx..."
sudo systemctl enable nginx
sudo systemctl start nginx

# Verify status
if systemctl is-active --quiet nginx; then
    echo "✅ Nginx is up and running."
else
    echo "❌ Nginx failed to start. Check logs with: journalctl -u nginx -n 20"
    exit 1
fi

# Open firewall ports (if ufw is active)
if command -v ufw &>/dev/null; then
    echo "Allowing Nginx through firewall (ufw)..."
    sudo ufw allow 'Nginx Full'
fi

echo ""
echo "=== Setup Complete ==="
echo "Visit http://localhost or http://<your-server-ip> to confirm it's working."
