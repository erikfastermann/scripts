#!/bin/bash

# A few functions to make your life easier when working with Pass
# Use with keyboard shortcuts for more usability

# Dependencies:
# Pass - https://www.passwordstore.org/
# dmenu - https://tools.suckless.org/dmenu/
# xdotool - https://www.semicomplete.com/projects/xdotool/
# xclip - https://github.com/astrand/xclip


# Config
PASSWORD_STORE_DIR="/home/erik/.password-store/"


# Select a file from the PASSWORD_STORE_DIR, the first option is the first line of the last_search file
# Prints the selection to stdout without file extension
pfile () {
	file_selected=$({ head -1 last_search ; find "$PASSWORD_STORE_DIR" -name "*.gpg" -type f -not -path '*.gpg-id' -printf "%P\n" | sed 's/\.[^.]*$//' ; } | dmenu)
	echo "$file_selected" | tee last_search
}

# Select a folder from the PASSWORD_STORE_DIR
pfolder () {
	folder_selected=$(find "$PASSWORD_STORE_DIR" -mindepth 1 -type d -printf "%P\n" | dmenu)
	echo "$folder_selected"
}


# Copy something into the primary selection without a trailing newline
clip () {
	tr -d '\n' | xclip
}


# Print username to stdout
username () {
	sed 's:.*/::'
}

# Print password to stdout
password () {
	pass "$(cat)"
}

# Print username and password, seperated by a space to stdout
user_pass () {
	file=$(pfile)
	echo "$(echo "$file" | username)" "$(echo "$file" | password)"
}


# Copy username to clipboard
un () {
	pfile | username | clip
}

# Copy password to clipboard
pw () {
	pfile | password | clip
}


# Automatically logs you in with xdotool
# typing username and password to currently active window
autologin () {
	current_window=$(xdotool getactivewindow)
	file=$(pfile)
	username=$(echo "$file" | username)
	password=$(echo "$file" | password)
	xdotool windowactivate "$current_window"
	xdotool type "$username"
	if [[ "$username" == *"@gmail.com" ]]; then
		xdotool key Return
		sleep 2
	else
		xdotool key Tab
	fi
	xdotool type "$password"
	xdotool key Return
}


# Run the functions directly
"$@"
