#!/bin/bash

function error() {
	echo "Error during setup: $1"
	echo "$EXIT_STATEMENT"
	exit 1
}

function setup_echo() {
	echo "SETUP SCRIPT: $1"
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

setup_echo "Cloning dotfiles repository"
dotfiles_path="$HOME/.dotfiles"

git clone --bare  https://github.com/SebastiaanBooman/dotfiles.git $dotfiles_path

#NOTE: This removes any conflicting files that are stored in the dotfiles. This is perfect for a fresh install, but beware when running this willy nilly
# The --git-dir and --work-tree options are persisently set in the .bashrc originating from the checked out repository
git checkout --git-dir=$HOME/.cfg/ --work-tree=$HOME 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} rm -f {}

# Install packages
setup_path="$HOME/setup"

dpkg_package_list_path=$setup_path/packages/dpkg.txt
if [ ! -f "$dpkg_package_list_path" ]; then
	error "Could not find dpkg packages list at $dpkg_package_list_path"
fi

setup_echo "Installing dpkg packages... (this may take a while)"
while read package; do
  sudo apt install -y -qq "$package"
done < $dpkg_package_list_path

which flatpak >/dev/null
if [ $? -ne 0 ]; then
	error "flatpak not found on system"
fi

flatpak_package_list_path=$setup_path/packages/flatpak.txt
if [ ! -f "$flatpak_package_list_path" ]; then
	error "Could not find flatpak packages list at $flatpak_package_list_path"
fi

setup_echo "Adding flathub remote"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

if [ $? -ne 0 ]; then
	error "Could not add flathub as remote"
fi

setup_echo "Installing flatpak packages..."
while read package; do
  sudo flatpak install flathub -y --noninteractive "$package"
done < $flatpak_package_list_path

# Set sudoers permissions
cp $dotfiles_path/sudo/sudoers /etc/sudoers

chmod +x ./parts/xob_setup.sh
chmod +x ./parts/neovim_setup.sh

# Building apps from source
# Install volume display package
setup_echo "Installing xob"
./parts/xob_setup.sh
# Install Neovim (Debian stable contains an ancient version :( )
setup_echo "Installing neovim"
./parts/neovim_setup.sh

# Reboot
echo "System setup completed successfully. Rebooting in 5 seconds..."

# wait for 15 seconds to cancel if necessary
sleep 5

systemctl reboot
