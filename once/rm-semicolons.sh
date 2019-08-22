#!/bin/bash

ls -1 | while read i; do
	new=$(echo "$i" | sed "s/'//g")
	mv "$i" "$new"
done
