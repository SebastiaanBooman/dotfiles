#!/bin/bash

# Script to setup xob for volume overlay/display

EXIT_STATEMENT="Skipping volume mixer (xob) installation"
MAKEFILE_NAME="Makefile"
XOB_PATH="$HOME/bin/xob"

function clean_up() {
	echo "cleaning up"
	cd /$HOME/

	if [ -f "$xob_path" ]; then
		rm -dr $xob_path
	fi
}

function error() {
	echo "Error during xob setup: $1"
	echo "$EXIT_STATEMENT"
	clean_up
	exit 1
}

if [[ $EUID -ne 0 ]]; then
	error "Must run with sudo priveleges"
fi

# required dependencies
libx11_installed=$(dpkg -l | grep libx11)
if [ -z "$libx11_installed" ]; then
	error "No libx11 library found, $exiting_script"
fi

libconfig_installed=$(dpkg -l | grep libconfig-dev)
if [ -z "$libconfig_installed" ]; then
	error "No libconfig-dev library found, $exiting_script"
fi

libxrender_installed=$(dpkg -l | grep librender)
if [ -z "$libxrender_installed" ]; then
	error "No libxrender found, $exiting_script"
fi

rm -fr $xob_path
git clone https://github.com/florentc/xob $xob_path
cd $xob_path

make
if [ $? -ne 0 ]; then
	error "Could not make makefile for xob, $exiting_script"
fi

sudo make install
if [ $? -ne 0 ]; then
	error "Could not install makefile for xob, $exiting_script"
fi

which xob > /dev/null
if [ $? -ne 0 ]; then
	error "Error during installation of xob"
else
	echo "succesfully installed xob!"
fi

