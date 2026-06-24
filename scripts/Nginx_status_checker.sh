#!/bin/bash

if systemctl is-active --quiet nginx; then
    echo "Nginx is running."
else
    echo "Nginx is NOT running."
fi
