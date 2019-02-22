#!/bin/bash

# Auto-commit every untracked/modified file separate
# Already added, renamed files will belong to the first commit

while read file; do
    git add "$file"
    bash "$(dirname ${BASH_SOURCE[0]})/auto-commit.sh"
    echo "----------"
done < <(git ls-files --other --modified)
