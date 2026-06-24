#!/bin/bash

if systemctl is-active --quiet ssh; then
    echo "SSH is running."
else
    echo "SSH is NOT running."
fi
