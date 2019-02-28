#!/bin/bash

# Select a line from a file in a chosen folder with fzf
# Enter: An editor opens at the selected line
# F1: Echo the selected line
# F2: Copy the selected line into clipboard with xclip
# F3: Copy after the last : to clipboard with xclip
# NOTE: If your $EDITOR isn't Vim, opening at a specific line might not work

set -e

search_dir="$1"
if [[ "$search_dir" == "" ]]; then
    search_dir="."
fi

find "$search_dir" -type f -not -path "*.git/*" | xargs grep -n -H . | sed "s+${search_dir}++" |
    fzf --header "Enter: Editor | F1: echo | F2: yank | F3: yank after last :" \
    --preview "head -100 \$(cut -d':' -f1 <<< ${search_dir}{})" \
    --bind "enter:execute:${EDITOR} \$(cut -d':' -f1 <<< ${search_dir}{}) \
        +\$(cut -d':' -f2 <<< {}) -c 'normal z.'" \
    --bind "f1:execute:echo {}" \
    --bind "f2:execute:echo -n {} | xclip" \
    --bind "f3:execute:echo -n {} | sed 's/.*:\s*//' | xclip"
