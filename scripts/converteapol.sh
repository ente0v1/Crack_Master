#!/bin/bash

# Prompt user for capture file input
ls .
echo -n "Capture file: "
read capture

# Check if capture file exists
if [ ! -f "$capture" ]; then
    echo "Error: Capture file '$capture' not found."
    exit 1
fi

# Extract ESSID list using hcxpcapngtool
hcxpcapngtool -o hash.txt -E essidlist "$capture"

# Check if essidlist file was generated
if [ ! -f "essidlist" ]; then
    echo "Error: Failed to generate 'essidlist' file."
    exit 1
fi

# Read ESSID from essidlist
ssid=$(cat essidlist)

# Create directory with ESSID name
mkdir -p "$ssid"

# Move hash file and essidlist to directory
mv hash.txt "$ssid/"
mv essidlist "$ssid/"

echo "Conversion completed successfully. Output stored in: $ssid/"
