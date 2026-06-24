#!/bin/bash

read -p "Enter website URL: " url

if curl -s -L "$url" > /dev/null
then
    echo "✅ Website is UP"
else
    echo "❌ Website is DOWN"
fi
