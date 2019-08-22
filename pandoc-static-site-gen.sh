#!/bin/bash

# Minimalistic static-site-generator using Pandoc + Markdown.

# Auto recompile and reload browser:
# find . | entr -s "./pandoc-static-site-gen.sh && reload-browser Firefox"

# Requirements:
# https://pandoc.org/
# http://eradman.com/entrproject/
# https://wiki.archlinux.de/title/Xdotool
# http://eradman.com/entrproject/scripts/reload-browser

# Todo:
# - auto-delete old files

# Config:
template_html="./.template/template.html"
export_dir="./.site/"

mkdir -p "$export_dir"

for dir in $(find * -type d) ; do
  mkdir -p "${export_dir}${dir}"
done

for file in $(find * -type f -name "*.md") ; do
  pandoc --toc -t html5 --template="$template_html" "$file" -o "${export_dir}${file%.md}.html"
done

# Notes:
# -not -path "*/\.*" -and -not -path ".*"
