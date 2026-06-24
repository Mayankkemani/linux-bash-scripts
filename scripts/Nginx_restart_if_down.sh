#!/bin/bash

if systemctl is-active --quiet nginx; then
    echo "✅ Nginx is already running. No action needed."
else
    echo "❌ Nginx is down. Restarting..."
    sudo systemctl restart nginx

    if systemctl is-active --quiet nginx; then
        echo "✅ Nginx restarted successfully."
    else
        echo "⚠️  Failed to restart Nginx. Manual intervention needed."
    fi
fi
