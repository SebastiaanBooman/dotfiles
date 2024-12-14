#!/bin/bash

clone_directory="$HOME/i3WorkspaceHistory"

git clone https://github.com/SebastiaanBooman/i3-workspace-history.git $clone_directory
if [ $? -ne 0 ]; then
	echo "Error during clone"
	exit
fi

go build "$clone_directory/i3-workspace-history.go"
if [ $? -ne 0 ]; then
	echo "Error go build"
	exit
fi

mv "$clone_directory/i3-workspace-history" /home/seb/bin/i3

rm -dr $clone_directory
echo "succesfully installed i3 workspace history"
