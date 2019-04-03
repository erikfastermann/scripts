#!/bin/bash

# Commit everything in the current folder by date.

while read -r line; do
    date=$(cut -d' ' -f1-3 <<< "$line")
    path=$(cut -d' ' -f4- <<< "$line")
    git add "$path"
    git commit --date "$date" -m "Added ${path}."
    #echo "$path"
    #echo "$date"
done < <(stat -c "%y %n" * | sort -n)
