#!/bin/bash

echo "Restarting Nginx..."
sudo systemctl restart nginx

if systemctl is-active --quiet nginx; then
    echo "✅ Nginx restarted successfully."
else
    echo "❌ Nginx failed to restart. Check logs for details."
fi
