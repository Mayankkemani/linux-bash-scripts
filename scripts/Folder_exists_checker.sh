#!/bin/bash

read -p "Enter folder name to check: " foldername

if [ -d "$foldername" ]; then
    echo "Folder '$foldername' exists."
else
    echo "Folder '$foldername' does not exist."
fi
