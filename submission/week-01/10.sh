#!/bin/bash

if [ -z "${1:-}" ]; then
    echo "Error: Missing target directory."
    echo "Usage: $0 <dir>"
    exit 1
fi

TARGET_DIR="$1"

if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: '$TARGET_DIR' is not a valid directory."
    exit 1
fi

du -k "$TARGET_DIR" 2>/dev/null | sort -rn | head -n 10