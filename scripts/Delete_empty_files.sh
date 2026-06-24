#!/bin/bash

read -p "Enter directory to clean: " dir

if [ -d "$dir" ]; then
    find "$dir" -type f -empty -delete
    echo "Empty files in '$dir' have been deleted."
else
    echo "Directory '$dir' does not exist."
fi
