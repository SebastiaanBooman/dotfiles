#!/bin/bash

#TODO: Remove this next line
# put quotes around variables to treat it as a single variable even if it contains whitespaces (eg for if -z)
# $? is the output statuscode of the last ran command, use it for checking whether command was succesful
# Script to setup a Debian system
# Prereq: git installed

function error() {
	echo "Error during setup: $1"
	echo "$EXIT_STATEMENT"
	#clean_up
	exit 1
}

# Must run script with sudo priveledges
if [[ $EUID -ne 0 ]]; then
	error "Must run with sudo priveleges"
fi


# Clone dotfiles repository
which git > /dev/null
if [ $? -ne 0 ]; then
	error "Git not found on system"
fi

dotfiles_path="$HOME/.dotfiles"

#TODO: Need to ignore the .dotfiles repository first to avoid recursion during clone?
git clone --bare  https://github.com/SebastiaanBooman/dotfiles.git $dotfiles_path

#NOTE: This removes any conflicting files that are stored in the dotfiles. This is perfect for a fresh install, but beware when running this willy nilly
git checkout --git-dir=$HOME/.cfg/ --work-tree=$HOME 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} rm -f {}

# Install packages
dpkg_package_list_path=$HOME/setup/packages/dpkg.txt
if [ -d "$dpkg_package_list_path" ]; then
	error "Could not find dpkg packages list at $dpkg_package_list_path"
fi

while read package; do
  sudo apt install -y "$package"
done < $dpkg_package_list_path

which flatpak >/dev/null
if [ $? -ne 0 ]; then
	error "flatpak not found on system"
fi

flatpak_package_list_path=$dotfiles_path/packages/flatpak.txt
if [ -d "$flatpak_package_list_path" ]; then
	error "Could not find flatpak packages list at $flatpak_package_list_path"
fi

# Set sudoers permissions
cp $dotfiles_path/sudo/sudoers /etc/sudoers

chmod +x ./parts/xob_setup.sh

# Install volume display package
./parts/xob_setup.sh

# Reboot
echo "System setup completed successfully. Rebooting in 5 seconds..."

# wait for 15 seconds to cancel if necessary
sleep 5

systemctl reboot
