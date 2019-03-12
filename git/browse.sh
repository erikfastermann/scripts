#!/bin/bash

# A fzf based script to browse some output containing commit-hashes

export FZF_DEFAULT_COMMAND="git log --color=always \
    --format='%Cred%h %Creset%s %Cblue(%ar) %Cgreen<%an>%Creset'"
while read -r line; do
    grep -o '[0-9a-f]\{7,40\}' <<< "$line" | xargs -n1 git rev-parse --verify -q
done < <(fzf --ansi -m --sync \
    --preview "git log -1 --color=always --format='' --stat \
        \$(grep -o '[0-9a-f]\{7,40\}' <<< {} |
        xargs -n1 git rev-parse --verify -q || echo -0) && 
        echo && git show --color=always \$(grep -o '[0-9a-f]\{7,40\}' <<< {} |
        xargs -n1 git rev-parse --verify -q || echo -0)")
