#!/bin/bash

if ping -c 1 8.8.8.8 &>/dev/null; then
    echo "✅ Internet is connected."
else
    echo "❌ No internet connection."
fi
