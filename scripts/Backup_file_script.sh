#!/bin/bash

read -p "Enter filename to back up: " filename

if [ -f "$filename" ]; then
    timestamp=$(date +'%Y%m%d_%H%M%S')
    backup_name="${filename}.bak_${timestamp}"
    cp "$filename" "$backup_name"
    echo "Backup created: $backup_name"
else
    echo "File '$filename' does not exist."
fi
