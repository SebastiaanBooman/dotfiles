#!/bin/bash

# This script starts Firefox and ensures that Firefox is not fullscreen (meaning tabs are always present) 
# and that i3 is fullscreen (meaning that the i3bar is visible)

i3-msg workspace "3"
i3-msg exec firefox

# Wait for firefox startup
for _ in {1..5}; do
	tree=$(i3-msg -t get_tree)
	# Prettiest code in my life
	firefox_started=$(echo $tree | grep -1 '"class":"firefox"')
	firefox_started_esr=$(echo $tree | grep -1 '"class":"firefox-esr"')
	if [[ $firefox_started || $firefox_started_esr ]]; then
		# Debouncer for i3 
		sleep 0.5
		i3-msg fullscreen toggle
		exit 0
	fi
	sleep 0.1
done

i3-nagbar -t warning -m 'Was unable to make Firefox fullscreen as Firefox process could not be found'
