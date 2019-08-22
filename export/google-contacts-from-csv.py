# USAGE:
# Go to https://takeout.google.com/ , download contacts as CSV.
# Change the 'contacts_csv' var to the path of your 'all contacts.csv' file.
# (English: 'Contacts/All Contacts/All contacts.csv')
# NOTE: If you don't want some categorie, just delete the column from the CSV file.

# CONFIG:
contacts_csv = "./Kontakte/Alle Kontakte/Alle Kontakte.csv"
# Export Settings:
export_path = "./export/" # Directory
# Change the name of catgories, keys (just add, if you want more/diffrent names)
categories = { "Home": "home", "Work": "work", "Mobile": "mobile", "Other": "",
"Obsolete": ""}
# My settings:
# categories = { "Home": "privat", "Work": "arbeit", "Mobile": "mobil", "Other": "privat",
# "Obsolete": "privat",  "Sonstiges": "privat", "Phone": "telefon", "Group Membership": "gruppe",
# "Uncategorized": "privat", "Name": "name", "E-mail": "email" }

# Variables for the CSV headers, you probably don't have to change them
csv_name = "Name"
uncategorized = "Uncategorized"
group_membership = "Group Membership"
phone = "Phone"
email = "E-mail"

import csv
import os
import codecs

# Extracting almost all keys (with non empty values)
def construct_dict(row):
    dict = {}
    for key, value in row.items():
        if group_membership in key or email in key or phone in key:
            pass
        else:
            if value: dict[key] = value
    return dict

# Extracting emails, phone numbers and their categories
def get_all(s, row):
    dict = {}
    try:
        counter = 0
        while True:
            counter += 1
            type = row[f"{s} {counter} - Type"].replace("* ", "")
            if not type:
                type = uncategorized
            values = [row[f"{s} {counter} - Value"]]
            if not values[0]:
                return dict
            if " ::: " in values[0]:
                values = values[0].split(" ::: ")
            if not type in dict:
                dict[type] = []
            for value in values:
                dict.setdefault(type, []).append(value)
    except:
        return dict

def extract_contacts(contacts_csv):
    all_data = []
    with open(contacts_csv, newline='', encoding='utf-8') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            row_data = construct_dict(row)
            group = row[group_membership].replace("* myContacts", "").replace(" ::: ", "")
            if group: row_data[group_membership] = group
            emails = get_all(email, row)
            if emails: row_data[email] = emails
            phones = get_all(phone, row)
            if phones: row_data[phone] = phones
            all_data.append(row_data)
    return all_data

def better_names(s):
    if s in categories:
        return categories[s]
    return s

def create_filepath(row):
    group = ""
    if group_membership in row:
        group = row[group_membership].lower() + "/"
    path = os.path.join(export_path, group)
    if not os.path.exists(path):
        os.makedirs(path)
    if csv_name in row:
        fullname = row[csv_name]
        path = os.path.join(path, fullname)
    elif email in row:
        email_user = next(iter(row[email].values()))[0]
        path = os.path.join(path, email_user)
    if os.path.isfile(path):
        counter = 2
        while os.path.isfile(f"{path} - {counter}"):
            counter += 1
        return f"{path} - {counter}"
    return path


if __name__ == "__main__":
    for row in extract_contacts(contacts_csv):
        filepath = create_filepath(row)
        print("->", filepath)
        with codecs.open(filepath, "w+", "utf-8") as f:
            for item, value in row.items():
                group_write = False
                if item == group_membership:
                    group_write = True
                if item == phone or item == email:
                    for sub_category in row[item]:
                        for entry in row[item][sub_category]:
                            item_final = better_names(item)
                            sub_category_final = better_names(sub_category)
                            splitter = "-"
                            if not sub_category_final: splitter = ""
                            line = f"{item_final}{splitter}{sub_category_final}: {entry}"
                            print(line)
                            f.write(f"{line}\n")
                else:
                    item_final = better_names(item)
                    line = f"{item_final}: {value}"
                    print(line)
                    if not group_write: f.write(f"{line}\n")
        print("---")
