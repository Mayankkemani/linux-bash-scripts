#!/bin/bash

read -p "Enter log directory to clean: " log_dir
read -p "Delete logs older than how many days?: " days

if [ ! -d "$log_dir" ]; then
    echo "Directory '$log_dir' does not exist."
    exit 1
fi

find "$log_dir" -type f -name "*.log" -mtime +"$days" -delete

echo "✅ Log files older than $days days have been deleted from '$log_dir'."
