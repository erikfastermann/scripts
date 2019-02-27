#!/bin/bash

# Search through key and value pairs in json files from a specific directory
# USAGE: search-lines-json.sh [dir]

set -e

search_dir="$1"
if [[ "$search_dir" == "" ]]; then
    search_dir="."
fi

get_json_pairs () {
    while read -r file; do
        while read -r jq_path; do
            echo "$(sed "s+${search_dir}++" <<< "$file"):" "${jq_path}:" $(jq -r ".${jq_path}" "$file")
        done < <(jq -r 'paths(scalars) | join(".")' $file)
    done < <(find "$search_dir" -name "*.json" -type f -not -path "*.git/*")
}

selected_pair=$(get_json_pairs | fzf)
echo "${selected_pair##*: }"
