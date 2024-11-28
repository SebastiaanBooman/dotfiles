
This repository contains configuration files not just for indivual applications, but also scripts to setup a basic Debian-based system to my liking.

How to configure:
1. Download/install a Debian ISO (not tested on any Debian derivatives but I would assume it should work also)
2. Install git on the system

`sudo apt install git`

3. Clone this repository using the bare flag following command (more information about bare repositories for dotfiles: https://www.atlassian.com/git/tutorials/dotfiles)

`git clone --bare https://github.com/SebastiaanBooman/dotfiles.git $HOME/.dotfiles`

4. Checkout the repository

`git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout`

5. Run the install script 

`$HOME/setup/setup.sh`

That is it :)
