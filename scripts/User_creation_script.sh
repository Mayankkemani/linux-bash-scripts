#!/bin/bash

read -p "Enter new username: " username

if id "$username" &>/dev/null; then
    echo "User '$username' already exists."
else
    sudo useradd -m "$username"
    echo "✅ User '$username' created."
    sudo passwd "$username"
fi
