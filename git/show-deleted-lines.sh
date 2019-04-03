#!/bin/bash

# Show all deleted lines from a file
# (comparing current version and all previous commits)

file="$1"
comm -23 <(git log --format='%h' -- "$file" | xargs -i git show "{}:${file}" | sort -u) <(sort "$file" )
