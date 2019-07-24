#!/bin/bash

#TO INSTALL: wget https://goo.gl/eWXEiO; mv eWXEiO ubuntu_install.sh; chmod +x ubuntu_install.sh; sudo bash ubuntu_install.sh


function say(){

    clear
    echo $1
    sleep $2
}

DOTFILE_URL='https://github.com/gagginaspinnata/dotfiles/archive/master.zip'

say "Initializing a new ubuntu OS" 2

say "Fixing the locale issue" 2

sudo locale-gen it_IT.UTF-8

sudo dpkg-reconfigure locales

say "Updating sources" 2

sudo apt-get update

say "Upgrading packages" 2

sudo apt-get upgrade -y

say "Installing required packages: vim, git, curl, wget, zip, unzip, htop, tmux" 5

sudo apt-get install vim git curl wget zip unzip htop tmux -y

echo "Do you want to install node/npm ? (y/n): "
	read node
	if [[  "$node" == 'y' ]];then
		say "Installing node and npm" 5
		curl -sL https://deb.nodesource.com/setup_12.x | sudo bash -
		sudo apt-get install -y nodejs build-essential

	fi


say "Downloading dotfiles" 2
#cd ~/
#wget $DOTFILE_URL

say "Installing dotfiles" 2

cd ~/
git clone https://github.com/gagginaspinnata/dotfiles.git
cd dotfiles
chmod +x install_bash.sh install_zsh.sh bootstrap.sh

bash bootstrap.sh
