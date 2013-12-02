#!/bin/bash
#
cd ~
git clone https://github.com/gagginaspinnata/dotfiles.git
cd dotfiles
chmod +x install_bash.sh install_zsh

bash bootstrap.sh
