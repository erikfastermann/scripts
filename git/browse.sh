#!/bin/bash

# Search through all commits or commits for a specific file
# USAGE: browse.sh [file]

set -e

git_folder=$(git rev-parse --show-toplevel)

git_file="$1"
if ! [[ "$git_file" ]]; then
    git_file=$(git -C "$git_folder" log --pretty=format: --name-only | sort -u | sed 's/^$/./' |
        fzf --ansi --preview "git -C $git_folder log --color=always --all \
        --format='%s %Cblue(%ar) %Cgreen<%an>%Creset' -- {}")
fi

git -C "$git_folder" log --color=always --all --follow \
    --format='%Cred%h %Creset%s %Cblue(%ar) %Cgreen<%an>%Creset' -- "$git_file" |
    fzf --ansi --header "$git_file | Enter: Less | F1: Echo | F2: Editor | F3: Checkout" \
    --preview "git -C $git_folder show --color=always \$(cut -c1-7 <<< {}) -- $git_file" \
    --bind "enter:execute:git -C $git_folder show --color=always \$(cut -c1-7 <<< {}) -- $git_file | less -r" \
    --bind "f1:execute:echo {}" \
    --bind "f2:execute:git -C $git_folder show --color=always \$(cut -c1-7 <<< {}):${git_file} | $EDITOR" \
    --bind "f3:execute:git -C $git_folder checkout \$(cut -c1-7 <<< {}) -- $git_file"
