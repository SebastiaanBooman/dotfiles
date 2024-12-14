#!/bin/bash

fzf_clone_directory="$HOME"/fzf

git clone https://github.com/junegunn/fzf.git $fzf_clone_directory
if [ $? -ne 0 ]; then
	echo "Error during fzf clone"
	exit
fi


make --directory=$fzf_clone_directory
if [ $? -ne 0 ]; then
	echo "Error during fzf make"
	exit
fi

sudo make --directory=$fzf_clone_directory install
if [ $? -ne 0 ]; then
	echo "Error during nvim make install"
	exit
fi

rm -dr $fzf_clone_directory
echo "succesfully installed fzf
