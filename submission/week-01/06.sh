#!/bin/bash

if [ $# -lt 4 ]; then
    echo "Error: Missing arguments."
    echo "Usage: $0 <max_attempts> <initial_delay_sec> -- <command> [args...]"
    exit 1
fi

MAX_ATTEMPTS=$1
INITIAL_SLEEP=$2
DELIMITER=$3

if [ "$DELIMITER" != "--" ]; then
    echo "Error: Expected '--' as the third argument."
    echo "Usage: $0 <max_attempts> <initial_delay_sec> -- <command> [args...]"
    exit 1
fi

shift 3
COMMAND=("$@")

if [ ${#COMMAND[@]} -eq 0 ]; then
    echo "Error: No command provided after '--'."
    exit 1
fi

ATTEMPT=1
SLEEP_TIME=$INITIAL_SLEEP

while [ $ATTEMPT -le $MAX_ATTEMPTS ]; do
    
    "${COMMAND[@]}"
    EXIT_CODE=$?
    
    if [ $EXIT_CODE -eq 0 ]; then
        exit 0
    fi
    
    if [ $ATTEMPT -lt $MAX_ATTEMPTS ]; then
        sleep "$SLEEP_TIME"
        SLEEP_TIME=$((SLEEP_TIME * 2))
    fi
    
    ATTEMPT=$((ATTEMPT + 1))
done

exit $EXIT_CODE