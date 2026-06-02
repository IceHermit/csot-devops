#!/usr/bin/env bash
set -euo pipefail

FILE="${TODO_FILE:-$HOME/.todo}"

touch "$FILE"

SUBCOMMAND="${1:-list}"

case "$SUBCOMMAND" in
    add)
        shift
        if [ $# -eq 0 ]; then
            echo "Error: 'add' requires task description text." >&2
            exit 2
        fi

        TEXT="$*"
        echo "[ ] $TEXT" >> "$FILE"
        exit 0
        ;;

    list)
        if [ -s "$FILE" ]; then
            awk '{ printf "%d: %s\n", NR, $0 }' "$FILE"
        fi
        exit 0
        ;;

    done)
        if [ -z "${2:-}" ] || ! [[ "$2" =~ ^[0-9]+$ ]]; then
            echo "Usage: $0 done <line_number>" >&2
            exit 2
        fi
        LINE_NUM="$2"

        sed -i "${LINE_NUM}s/^\[ \]/[x]/" "$FILE"
        exit 0
        ;;

    remove)
        if [ -z "${2:-}" ] || ! [[ "$2" =~ ^[0-9]+$ ]]; then
            echo "Usage: $0 remove <line_number>" >&2
            exit 2
        fi
        LINE_NUM="$2"
        sed -i "${LINE_NUM}d" "$FILE"
        exit 0
        ;;

    *)
        echo "Usage: $0 {add|list|done|remove} [arguments]" >&2
        exit 2
        ;;
