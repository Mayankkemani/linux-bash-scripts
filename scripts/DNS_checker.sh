#!/bin/bash

read -p "Enter domain name to check (e.g. google.com): " domain

if nslookup "$domain" &>/dev/null; then
    echo "✅ DNS resolution successful for $domain."
    nslookup "$domain"
else
    echo "❌ DNS resolution failed for $domain."
fi
