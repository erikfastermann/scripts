#!/bin/bash

# USAGE: auto-commit.sh [git-repo]

# CONFIG
git_modified="Modified"
git_added="Added"
git_deleted="Deleted"
git_renamed="Renamed"
git_copied="Copied"


set -e

git_repo="$1"
if [[ "$git_repo" == "" ]]; then
    git_repo="."
fi


check_dirty () {
    if ! [[ $(git -C "$git_repo" status --porcelain) ]]; then
        echo "Nothing to commit. Exiting..."
        exit 0
    fi
}

check_staged () {
    local IFS=$'\n'
    for file in $(git diff --name-only --staged); do
        git_files_staged="${git_files_staged}"'"'"${file}"'" '
    done
}

parse_status () {
    cur_modified=()
    cur_added=()
    cur_deleted=()
    cur_renamed=()
    cur_copied=()

    while read -r line; do
        local status_code
        local file_name
        status_code=$(echo "$line" | cut -d ' ' -f1)
        file_name=$(echo "$line" | cut -d ' ' -f2- | awk '{$1=$1};1' )

        case "$status_code" in
            "??")
                cur_added+=("$file_name")
                ;;
            *"A")
                cur_added+=("$file_name")
                ;;
            *"M")
                cur_modified+=("$file_name")
                ;;
            *"D")
                cur_deleted+=("$file_name")
                ;;
            *"R")
                cur_renamed+=("$file_name")
                ;;
            *"C")
                cur_copied+=("$file_name")
                ;;
        esac
    done < <(echo "$git_files_staged" | xargs git -C "$git_repo" status --porcelain --short --untracked -- )
}

create_msg () {
    local msg=""
    declare -a files_array=("${!1}")
    if [[ "$files_array" == "" ]]; then
        return
    fi
    for file in "${files_array[@]}"; do
        msg+="${file}, "
    done
    full_commit_msg+="$2 ${msg::-2}. "
}

create_commit () {
    full_commit_msg=""
    create_msg cur_added[@] "$git_added"
    create_msg cur_modified[@] "$git_modified"
    create_msg cur_deleted[@] "$git_deleted"
    create_msg cur_renamed[@] "$git_renamed"
    create_msg cur_copied[@] "$git_copied"
    full_commit_msg="[AUTO] ${full_commit_msg::-1}"

    if [[ "$git_files_staged" == "" ]]; then
        git -C "$git_repo" add -A
    fi
    git -C "$git_repo" commit -m "$full_commit_msg"
}


check_dirty
check_staged
parse_status
create_commit
