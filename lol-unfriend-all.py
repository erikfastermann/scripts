import pyautogui
import time

pyautogui.PAUSE = 0.1
pyautogui.FAILSAFE = True

print("League of Legends - Client size: 1920x1080")
number_friends = input("Number of friends? ")
print("Move the cursor on the icon of the first person in your friendlist...")
time.sleep(5)
for i in range(int(number_friends)):
    start_position = pyautogui.position()
    pyautogui.click(button='right')
    pyautogui.moveRel(100, 280, duration=0.25)
    pyautogui.click()
    pyautogui.moveRel(-825, 110, duration=0.25)
    pyautogui.click()
    pyautogui.moveTo(start_position.x, start_position.y, duration=0.25)
