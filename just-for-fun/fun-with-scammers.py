# A script to annoy the scammers.
# Flood a website with fake usernames and passwords.

# NOTE: For demonstrational purposes only. Use at your own risk.

# DEPENDENCIES
# Python 3.6 or newer - https://www.python.org/downloads/
# Selenium - pip install selenium
# geckodriver (Firefox) - https://github.com/mozilla/geckodriver/releases
# Fake user names - e.g.: https://www.fakenamegenerator.com/order.php

# CONFIG
website = ""
csv_file_user = "fake_user_data.csv"


from random import randint
import secrets
import string
import time
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import csv


def browser(username, password):
    driver = webdriver.Firefox()
    driver.get(website)

    login_field = driver.find_element_by_id("login-form-username")
    login_field.send_keys(username)

    password_field = driver.find_element_by_id("login-form-password")
    password_field.send_keys(password)

    login_button = driver.find_element_by_tag_name("button")
    login_button.click()
    
    time.sleep(1)
    driver.close()


if __name__ == "__main__":
    with open(csv_file_user, newline='') as csvfile:
        reader = csv.DictReader(csvfile)
        
        current_number = 0
        start_time = time.time()
        
        for row in reader:
            current_number += 1
            elapsed_time = time.strftime("%H:%M:%S", time.gmtime(time.time() - start_time))
            
            username = row["Username"]
            alpha_num = string.ascii_letters + string.digits
            password = ''.join(secrets.choice(alpha_num) for i in range(randint(8, 20)))
            
            print(f"{elapsed_time} - {current_number}: {username} - {password}")
            browser(username, password)
