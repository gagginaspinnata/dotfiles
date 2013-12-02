#!/bin/bash

clear

echo "           __      __  _____ __
      ____/ /___  / /_/ __(_) /__  _____
     / __  / __ \/ __/ /_/ / / _ \/ ___/
    / /_/ / /_/ / /_/ __/ / /  __(__  )
    \__,_/\____/\__/_/ /_/_/\___/____/
                                        "

echo $"Choose if you want to install [z]sh or [b]ash dotfiles: "
read shell

cd ~
git clone https://github.com/gagginaspinnata/dotfiles.git
cd dotfiles
chmod +x install_bash.sh install_zsh


if [[ "$shell" == "b" ]]; then

    bash install_bash.sh
else
    bash install_zsh.sh
fi
