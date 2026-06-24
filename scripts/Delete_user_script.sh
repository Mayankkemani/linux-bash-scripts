#!/bin/bash

read -p "Enter username to delete: " username

if id "$username" &>/dev/null; then
    sudo userdel -r "$username"
    echo "✅ User '$username' deleted (including home directory)."
else
    echo "❌ User '$username' does not exist."
fi

