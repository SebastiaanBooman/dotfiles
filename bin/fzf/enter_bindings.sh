#!/bin/bash

# Script that opens the file in various editors based on its extension
# I should probably look around online for more defacto configs with FZF instead of writing my own scripts heh
if [ -d "$1" ]; then
	echo "$1"
	$HOME/bin/fzf/test.sh
elif [[ "$1" =~ \.(png|jpg|jpeg)$ ]]; then  #?i makes case insensitive 
	feh "$1"
elif [[ "$1" =~ \.pdf$ ]]; then 
	 echo "$1" - | head -n 40
else 
	nvim "$1" # Open nvim by default ;)
fi

