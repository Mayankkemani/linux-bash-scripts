#!/bin/bash

read -p "Enter host/IP: " host
read -p "Enter port number: " port

if nc -zv "$host" "$port" 2>/dev/null
then
    echo "✅ Port $port is OPEN on $host"
else
    echo "❌ Port $port is CLOSED on $host"
fi
