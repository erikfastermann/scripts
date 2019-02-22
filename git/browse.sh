#!/bin/bash

# Browse commits for a specific file, view commit in $EDITOR
# USAGE: browse.sh dir

git_folder="$1"
if [[ "$git_folder" == "" ]]; then
    git_folder="."
fi

while git_file="$(git -C $git_folder log --pretty=format: --name-only \
    | sort -u | grep . | fzf)"; [[ "$git_file" ]]; do
    while git_commit="$(git -C $git_folder log --follow --pretty=format:'%C(auto)%h %Cblue(%an %ar)%Creset %s' \
        -- $git_file | fzf | cut -c1-7)"; [[ "$git_commit" ]]; do
        git -C "$git_folder" show "${git_commit}:${git_file}" | "$EDITOR"
    done
done
