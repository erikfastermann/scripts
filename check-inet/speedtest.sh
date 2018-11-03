#!/bin/bash

# For more reliable results I now use speedtest-cli 
# ( https://github.com/sivel/speedtest-cli )


while :
do
	echo $(date +"%d.%m.%Y,%H:%M:%S,") $(speedtest-cli --csv) >> OUTPUT.csv
	sleep 600
done