#!/bin/bash

# Check if all lines in files from a specified directory
# have only the keys, that are defined in a your template.
# A key is everything in a line before the first ':'.
# USAGE: check-keys.sh [dir] [template]
# DEPENDENCIES: fd - https://github.com/sharkdp/fd

set -e

check_dir="$1"
if ! [[ "$check_dir" ]]; then
    check_dir="."
fi
if ! [ -d "$check_dir" ]; then
    echo "Directory not found!"
    exit 1
fi

template_file="$2"
if ! [[ "$template_file" ]]; then
    template_file="${check_dir}/template"
fi
if ! [ -f "$template_file" ]; then
    echo "Template not found!"
    exit 1
fi

while read -r file; do
    while read -r line; do
        grep -Fw "$line" "$template_file" > /dev/null || >&2 echo "Unrecognized: $file - $line"
    done < <(cut -d':' -f1 "$file")
done < <(fd . "$check_dir" --type f -E "$template_file")
