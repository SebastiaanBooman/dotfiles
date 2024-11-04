#!/bin/bash

# This script starts Firefox and ensures that Firefox is not fullscreen (meaning tabs are always present) 
# and that i3 is fullscreen (meaning that the i3bar is visible)

i3-msg workspace "3"
i3-msg exec firefox

# Wait for firefox startup
for _ in {1..10}; do
	tree=$(i3-msg -t get_tree)
	if echo $tree | grep -q '"class":"firefox"' || echo $tree | grep -q '"class":"firefox-esr"'; then
		# Debouncer for i3 
		sleep 0.5
		i3-msg fullscreen toggle
		exit 0
	fi
	sleep 0.1
done

i3-nagbar -t warning -m 'Was unable to make Firefox fullscreen as Firefox process could not be found'
