#!/bin/bash

# similar script for BASH
# based on https://askubuntu.com/a/137246 by achu


echo "filename:"
read filename

ping -i 600 -O 8.8.8.8 | while read pong; do echo "$(date): $pong"; done &> $filename".log"