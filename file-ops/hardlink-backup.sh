#!/bin/bash

# Create directories and hardlinks based on a path
# Use this before a mass rename
# USAGE: hardlink-backup.sh [dir]

set -e

orig_dir="$1"
if [ ! -d "$orig_dir" ]; then
    >&2 echo "No or not existing path given. Exiting..."
    exit 1
fi

#find "$orig_dir" -type d -printf "%P\n" | xargs mkdir -p
while read -r file; do
    path="\"$file\""
    full_path="\"${orig_dir}/${file}\""
    #echo "$path"
    #echo "$full_path"
    [ -f "$full_path" ] && echo "$full_path"
done < <(find "$orig_dir" -type f -printf "%P\n")
