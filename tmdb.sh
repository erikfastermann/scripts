#!/bin/bash

# Get TV show episodes from themoviedb.com
# NOTE: Account with API Key needed ( https://www.themoviedb.org/settings/api )

# DEPENDENCIES:
# fzf - https://github.com/junegunn/fzf
# curl - https://curl.haxx.se/

# USAGE: ./tmdb.sh Search query

# SETTINGS:
API_KEY="$TMDB"
lang='de-DE'


set -e

query="$(sed 's/ /%20/g' <<< "$*")"
show="$(curl "https://api.themoviedb.org/3/search/tv?api_key=${API_KEY}&language=${lang}&query=${query}&page=1" |
    jq -r '.results[] | "\(.id) \(.name)"' | fzf | cut -d' ' -f1)"

seasons="$(curl "https://api.themoviedb.org/3/tv/${show}?api_key=${API_KEY}&language=${lang}" | jq -r '.seasons[].season_number')"
seasons_sel="$(fzf <<< "$seasons")" && seasons="$seasons_sel"

while read -r season; do
     curl "https://api.themoviedb.org/3/tv/${show}/season/${season}?api_key=${API_KEY}&language=${lang}" |
         jq -r '.episodes[] | "\(.season_number)x\(.episode_number) - \(.name)"'
done <<< "$seasons"
