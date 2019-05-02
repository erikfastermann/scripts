#!/bin/bash

# A file-browser using fzf.
# USAGE: . ./browse.sh

file_menu='1 - Less
2 - Editor
3 - mpv'

option_menu='9 - exit'

while true; do
    out="$(find . -maxdepth 1 -print0 | sed -z 's/^.$/../' |
        fzf --read0 --ansi --header "$PWD" --preview \
        'if [ "$(file --mime-encoding {} | awk \{print\$NF\})" != "binary" ]; \
            then head -100 {}; else if [ -d {} ]; then ls -1A --color=always {}; \
            else file {} | tr "," "\n"; fi; fi' \
        --print-query)"
    exit_code="$?"
    if [ "$exit_code" == '130' ]; then
        break
    fi
    if [ "$exit_code" == '0' ]; then
        file="$(sed '2q;d' <<< "$out")"
        if [ -d "$file" ]; then
            builtin cd "$file"
            continue
        fi
        if [ -f "$file" ]; then
            if menu="$(fzf --header "Option for $file" <<< "$file_menu")"; then
                option="$(cut -d' ' -f1 <<< "$menu")"
                case "$option" in
                    1) less "$file" ;;
                    2) "$EDITOR" "$file" ;;
                    3) mpv "$file" & ;;
                esac
            fi
            continue
        fi
        echo 'Error!'
        break
    fi
    if menu="$(fzf --header "Exit code: ${exit_code}. Select an option..." <<< "$option_menu")"; then
        option="$(cut -d' ' -f1 <<< "$menu")"
        case "$option" in
            9) break ;;
        esac
    fi
done
