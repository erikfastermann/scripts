#!/bin/bash

set -e

git_dir="$(git rev-parse --show-toplevel)"

get_lines () {
    git log --format='' --name-only | sort -u |
    while read -r file; do
        while read -r hash; do
            git show "${hash}:${file}" | awk -v hash="$hash" -v file="$file" \
                '{ print hash "|" file "|" $0 }'
        done < <(git -C "$git_dir" log --format='%h' -- "$file")
    done < <(fzf -m --ansi --preview "git -C $git_dir log --color=always \
        --format='%C(auto)%h%d %s %Cblue(%ar) %Cgreen<%an>%Creset' -- {}")
}

get_lines | sort -u | bash "${SCRIPTS}/git/browse.sh"
