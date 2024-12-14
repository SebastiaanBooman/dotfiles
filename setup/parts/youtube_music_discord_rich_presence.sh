#!/bin/bash

mkdir "$HOME/src"
clone_directory="$HOME/src/youtube-music-discord-rich-presence"

git clone https://github.com/SebastiaanBooman/youtube-music-discord-rich-presence.git $clone_directory
if [ $? -ne 0 ]; then
	echo "Error during clone"
	exit
fi

#TODO: Improve install method for this app
go build $clone_directory/gobackend/main.go

if [ $? -ne 0 ]; then
	echo "Error during build (go probably not installed)"
	exit
fi

echo "succesfully installed youtube music discord rich presence app
