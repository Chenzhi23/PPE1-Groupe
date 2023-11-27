#!/bin/bash

# Check if the input argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 japonais.txt"
    exit 1
fi

# Check if the file containing URLs exists
if [ ! -f "$1" ]; then
    echo "Error: File '$1' does not exist."
    exit 1
fi

# Check if lynx is installed
if ! command -v lynx &> /dev/null; then
    echo "Error: lynx is not installed. Please install lynx to use this script."
    exit 1
fi

# Process each URL in the file
while IFS= read -r URL; do
    lynx --dump -assume_charset=utf-8 --display_charset=utf-8 "$URL" | \
    sed -n '/^References/,$!p' | \
    awk '/References/{exit} {if(length($0)>0) print}' | \
    grep -v '^[[:space:]]*$' | \
    sed 's/[A-Za-z[:punct:]]//g'
    echo "------------------------------------------------"
done < "$1"
