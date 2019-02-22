# Select a line from a file in a chosen folder with fzf,
# then an editor opens at the specified line
sl () {
    local search_dir="$1"
    if [[ "$search_dir" == "" ]]; then
        search_dir="."
    fi
    local selected_line=$(find "$search_dir" -type f -not -path "*.git/*" | xargs grep -n -H . | sed "s+${search_dir}++" | fzf)
    if [[ "$selected_line" ]]; then
        local selected_path=$(echo "${search_dir}${selected_line}" | cut -d ':' -f1)
        local selected_line_number=$(echo "$selected_line" | cut -d ':' -f2)
        "$EDITOR" "$selected_path" +"${selected_line_number}" -c 'normal z.'
    fi
}