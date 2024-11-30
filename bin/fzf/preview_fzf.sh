#!/bin/bash

# Check file extension and display preview accordingly 
if [ -d "$1" ]; then
	ls "$1"
elif [[ "$1" =~ \.(png|jpg|jpeg)$ ]]; then  #?i makes case insensitive 
	chafa "$1"
elif [[ "$1" =~ \.pdf$ ]]; then 
	pdftotext "$1" - | head -n 40
else 
	head -n 40 "$1"
fi
