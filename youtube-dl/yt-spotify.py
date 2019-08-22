"""USAGE: Select some songs in the Spotify client. Then right-click -> Share ->
Copy (embed)."""

import sys
import requests
from bs4 import BeautifulSoup as bs
import json
import youtube_dl
import threading
import time

ydl_opts = {
    'nooverwrites': True,
    'ignoreerrors': True,
    'format': 'bestaudio/best',
    'postprocessors': [{
            'key': 'FFmpegExtractAudio',
            'preferredcodec': 'mp3'
            }]
}
def parser(line):
    s = bs(requests.get(bs(line, 'html.parser').find('iframe')['src']).text, 'html.parser')
    j = json.loads(s.find('script', id='resource').text)
    artist = j['artists'][0]['name']
    name = j['name']
    with youtube_dl.YoutubeDL(ydl_opts) as ydl:
        ydl.extract_info(f'ytsearch:{artist} - {name}')

for line in sys.stdin:
    parser(line)
    # threading.Thread(target=parser, args=[line]).start()
