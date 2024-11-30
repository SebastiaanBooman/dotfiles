#!/bin/bash

git clone https://github.com/neovim/neovim.git $HOME/neovim
if [ $? -ne 0 ]; then
	echo "Error during nvim clone"
	exit
fi

nvim_clone_directory="$HOME"/neovim

make --directory=$nvim_clone_directory CMAKE_BUILD_TYPE=RelWithDebInfo
if [ $? -ne 0 ]; then
	echo "Error during nvim make"
	exit
fi

sudo make --directory=$nvim_clone_directory install
if [ $? -ne 0 ]; then
	echo "Error during nvim make install"
	exit
fi

rm -dr $nvim_clone_directory
echo "succesfully installed Neovim
