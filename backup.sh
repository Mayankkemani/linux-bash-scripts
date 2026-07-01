#!/bin/bash

echo "Enter the file name"
read file

if [ -f $file ]
then 
   cp $file $file.bak
  echo "backup created"
else
   echo "backup not created file not found"
fi
