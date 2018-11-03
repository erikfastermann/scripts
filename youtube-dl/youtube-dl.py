import os
import csv
import youtube_dl

def main():
    if not os.path.isdir('archive'):
        os.mkdir('archive')

    with open('youtube.csv') as csv_file:
        csv_reader = csv.reader(csv_file)
        for row in csv_reader:
            download(playlistName=row[0], playlistId=row[1])

def download(playlistName, playlistId):
    ydl_opts = {
        'download_archive': f'archive/{playlistName}.txt',
        'nooverwrites': True,
        'ignoreerrors': True,
        'format': 'bestaudio/best',
        'outtmpl': f'music/{playlistName}/%(title)s.%(ext)s',
        'postprocessors': [{
            'key': 'FFmpegExtractAudio',
            'preferredcodec': 'mp3'
        },
        # {
        #     'key': 'FFmpegMetadata'
        # },
        # {
        #     'key': 'MetadataFromTitle',
        #     'titleformat': '%(artist)s - %(title)s'
        # }
        ]
    }

    with youtube_dl.YoutubeDL(ydl_opts) as ydl:
        ydl.extract_info(playlistId, download=True)

if __name__ == '__main__':
    main()
