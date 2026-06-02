#!/bin/bash

if [ -z "$1" ]; then
    echo "Error: Please provide a file path."
    echo "Usage: $0 /path/to/file.txt"
    exit 1
fi

FILE_PATH=$1

if [ ! -f "$FILE_PATH" ]; then
    echo "Error: '$FILE_PATH' does not exist or is not a regular file."
    exit 1
fi

awk '{print $1}' $FILE_PATH | sort -u | wc -l