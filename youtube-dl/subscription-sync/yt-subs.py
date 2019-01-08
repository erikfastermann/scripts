"""This script creates a batch file out of your YouTube subscriptions for youtube_dl.
It uses the OPML file for RSS readers from YouTube. You can download it here:
https://www.youtube.com/subscription_manager?action_takeout=1

USAGE: yt-subs.py [INPUT FILE (XML/OPML)] [OUTPUT FILE]
Requires the OPML package ( pip install opml )
By default everything in the output file is commented out.
"""

import sys
import opml

stand_in_file = "subs.xml"
stand_out_file = "subs.txt"

def main():
    if len(sys.argv) == 1:
        parser(stand_in_file, stand_out_file)
        return
    if len(sys.argv) == 3:
        input_file = sys.argv[1]
        output_file = sys.argv[2]
        parser(input_file, output_file)
        return
    script_name = sys.argv[0]
    print(f"USAGE: {script_name} [INPUT FILE (XML/OPML)] [OUTPUT FILE]")

def parser(input_file, output_file):
    outline = opml.parse(input_file)

    with open(output_file, "a+") as f:
        counter = 0
        f.seek(0, 0)
        subs = f.read()
        for i in range(len(outline[0])):
            text = outline[0][i].text
            id = outline[0][i].xmlUrl.split("id=", 1)[1]
            if not id in subs:
                f.write(f"\n## {text}\n# www.youtube.com/channel/{id}\n")
                counter += 1
        print(f"Added {counter} Channel(s)!")

if __name__ == "__main__":
    main()
