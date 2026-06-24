#!/bin/bash

read -p "Enter filename to check: " filename

if [ -f "$filename" ]; then
    echo "File '$filename' exists."
else
    echo "File '$filename' does not exist."
fi
