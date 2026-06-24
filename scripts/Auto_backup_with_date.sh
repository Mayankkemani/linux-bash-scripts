#!/bin/bash

read -p "Enter folder to back up: " source_dir
read -p "Enter backup destination folder: " dest_dir

if [ ! -d "$source_dir" ]; then
    echo "Source folder '$source_dir' does not exist."
    exit 1
fi

if [ ! -d "$dest_dir" ]; then
    echo "Destination folder '$dest_dir' does not exist. Creating it..."
    mkdir -p "$dest_dir"
fi

timestamp=$(date +'%Y%m%d_%H%M%S')
backup_name="backup_${timestamp}.tar.gz"

tar -czf "${dest_dir}/${backup_name}" -C "$(dirname "$source_dir")" "$(basename "$source_dir")"

if [ $? -eq 0 ]; then
    echo "✅ Backup created: ${dest_dir}/${backup_name}"
else
    echo "❌ Backup failed."
fi
