#!/bin/bash

echo "Enter file name:"
read file

if [ -f $file ]
then
    echo "File Exists"
else
    echo "File Not Found"
fi
