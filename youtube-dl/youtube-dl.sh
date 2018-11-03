#!/bin/bash

python3 -m youtube_dl --download-archive archive.txt --no-post-overwrites -ciwx --audio-format mp3 -o "music/%(playlist)s/%(title)s.%(ext)s" -a youtube.txt