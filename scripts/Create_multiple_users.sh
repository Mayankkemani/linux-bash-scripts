#!/bin/bash

read -p "Enter path to usernames file (one username per line): " user_file

if [ ! -f "$user_file" ]; then
    echo "File '$user_file' does not exist."
    exit 1
fi

while IFS= read -r username; do
    [ -z "$username" ] && continue   # skip empty lines

    if id "$username" &>/dev/null; then
        echo "⚠️  User '$username' already exists. Skipping."
    else
        sudo useradd -m "$username"
        echo "✅ User '$username' created."
    fi
done < "$user_file"

echo "Done processing all users."
