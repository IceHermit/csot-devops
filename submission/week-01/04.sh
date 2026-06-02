#!/bin/bash

if [ -z "$1" ]; then
    echo "Error: Please provide a directory path."
    echo "Usage: $0 /path/to/directory"
    exit 1
fi

TARGET_DIR=$1

if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: '$TARGET_DIR' is not a valid directory or does not exist."
    exit 1
fi

find "$TARGET_DIR" -type f -name "*.txt" -print0 | xargs -0 -I {} sh -c 'mv "$1" "${1%.txt}.md"' _ {}