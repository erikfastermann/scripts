#!/bin/bash

# Execute commands on all non bare repositories from a folder
# USAGE: exec-on-all-repos.sh dir args...

find_dir="$1"
if [[ "$find_dir" == "" ]]; then
    find_dir="$HOME"
fi
exec_command="${*:2}"
if [[ "$exec_command" == "" ]]; then
    exec_command="pwd"
fi

find "$find_dir" -name .git -type d -execdir bash -c "$exec_command" \;
