#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

symlink() {
    source="$SCRIPT_DIR/$1"
    destination="$HOME/$2"

    mkdir -p "$(dirname $destination)"

    if [ -L "$destination" ]; then
        echo "[WARNING] symlink already exists at $destination. Skipping this one."
        continue
    fi

    if [ -e "$destination" ]; then
        echo "[ERROR] $destination already exists but is not a symlink. Please fix it manually."
        exit 1
    fi

    ln -s "$source" "$destination"
    echo "[SUCCESS] $source -> $destination"
}


deploy() {
    while read -r line; do
        if [[ "$line" =~ ^#.* ]]; then
            echo "[INFO] Skipping this line: $line"
            continue
        fi

        source_filename="$(echo "$line" | cut -d '|' -f 1 | xargs)"
        destination_filename="$(echo "$line" | cut -d '|' -f 2 | xargs)"

        symlink "$source_filename" "$destination_filename"
    done < "$SCRIPT_DIR/$1"
}

if [ $# -eq 0 ]; then
    echo "[ERROR] No MANIFEST file provided!" >&2
    echo "Usage: $0 <MANIFEST>" >&2
    exit 1
fi

deploy "$1"
