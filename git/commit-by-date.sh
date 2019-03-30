#!/bin/bash

# Commit everything in the current folder by date.

while read -r line; do
    path=$(awk '{ print $NF }' <<< "$line")
    date=$(awk '{ print $5 " " $6 " " $7 }' <<< "$line")
    git add "$path"
    git commit --date "$date" -m "Added ${path}."
done < <(ls -lrt --full-time | tail -n +2)
