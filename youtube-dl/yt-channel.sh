#!/bin/sh

urls="subs.txt"
archive="archive.txt"

python3 -m youtube_dl -i -a $urls --download-archive $archive \
-f best -o "%(uploader)s/%(upload_date)s-%(title)s.%(ext)s"
