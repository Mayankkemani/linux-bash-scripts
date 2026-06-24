#!/bin/bash

echo "Checking for failed services..."
systemctl --failed
