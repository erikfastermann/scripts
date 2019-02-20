"""Export your 'Google Notes' to a Markdown and folder based structure.

WARNING: Only saves 1 label per note.
Currently not supported: Audio, Reminders, Coworkers, Colors, Trash.

USAGE: Download your notes from https://takeout.google.com/ . Extract the archive
and change the notes_path variable to the notes folder from the takeout
(contains a lot of HTML files). Execute the script. Done!"""

import os
import codecs
import string
import re
import base64
from datetime import datetime
from bs4 import BeautifulSoup as bs

# Config
notes_path = "./Notes/"
export_path = "./Export/"

# Make string a valid filename
def format_filenames(s):
    valid_chars = "-_.() %s%s" % (string.ascii_letters, string.digits)
    return ''.join(c for c in s if c in valid_chars)

# Main part
for file in os.listdir(notes_path):
    if file.endswith(".html"):
        with codecs.open(os.path.join(notes_path, file), "rb", "utf-8") as f:
            print(file)
            soup = bs(f, "lxml")

            # Date
            date = soup.find("div", "heading").text.strip()
            date = datetime.strptime(date, "%d.%m.%Y,  %H:%M:%S")
            date = date.strftime("%Y-%m-%d  %H-%M-%S")

            # Label
            category = soup.find("span", "label-name")
            if category:
                category = format_filenames(category.text)
            else:
                category = "Uncategorized"

            # Title
            title = soup.find("div", "title")
            if title:
                title = title.text
            else:
                title = date
            title = format_filenames(title)

            # Archive
            archive = ""
            if soup.find("span", "archived"):
                archive = "."

            # Create Folder
            dir = os.path.join(export_path, category)
            if not os.path.exists(dir):
                os.makedirs(dir)

            # New filename
            filename = f"{title}.md"
            if os.path.isfile(os.path.join(dir, filename)):
                i = 1
                while os.path.isfile(os.path.join(dir, f"{title} ({i}).md")):
                    i += 1
                filename = f"{title} ({i}).md"
            path = os.path.join(dir, f"{archive}{filename}")
            print("--->", path)

            # Create and open export file
            with codecs.open(path, "w+", "utf-8") as nf:
                # Images
                attach = soup.find("div", "attachments")
                if attach:
                    img = attach.findChild("img")
                    if img:
                        new_name, _ = os.path.splitext(filename)
                        base64_data = img['src']
                        img_type = ".png"
                        if "jpeg" in base64_data:
                            img_type = ".jpg"
                        base64_data = base64_data.split(",", 1)[1]
                        with open(os.path.join(dir, f"{new_name}{img_type}"), "wb") as fh:
                            fh.write(base64.b64decode(base64_data))
                        nf.write(f'<"./{new_name}{img_type}">\n')

                # List-Items
                found_list = False
                list = soup.find_all("span", "text")
                if list:
                    found_list = True
                    for span_text in list:
                        item = span_text.text
                        if span_text.find_parent("li", "listitem checked"):
                            nf.write(f"[x] {item}\n")
                        else:
                            nf.write(f"[ ] {item}\n")

                # Content
                if not found_list:
                    content = soup.find("div", "content")
                    if content:
                        nf.writelines(content.get_text(separator='\n'))

            print()
