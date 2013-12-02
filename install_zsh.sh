#!/bin/bash


dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory

function alert(){
    clear
    echo $1
    sleep $2
}


alert "Checking what OS are you running.." 2

if [[ "$OSTYPE" == "linux-gnu" ]]; then
        OS='linux'
elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS='mac'
elif [[ "$OSTYPE" == "win32" ]]; then
        OS='window'
elif [[ "$OSTYPE" == "freebsd"* ]]; then
        OS='bsd'
fi

if [[ "$OS" == "linux" ]]; then
    alert "Installing zsh from apt .." 2
    apt-get install zsh
fi

alert "Downloading and installing the oh-my-zsh framework .." 2
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

alert "Copying alias and functions files to custom zsh directory .." 2
cp $dir/bash_alias ~/.oh-my-zsh/custom/alias.zsh
cp $dir/bash_functions ~/.oh-my-zsh/custom/functions.zsh

if [[ "$OS" == 'mac' ]]; then
    alert "Creating a symlink for the .osx file .." 2
    ln -s $dir/osx ~/.osx
fi

# moving vimrc files to root
alert "Creating a symlink for the .vimrc file .." 2
ln -s $dir/vimrc ~/.vimrc

# changing the default theme
alert "Setting the ys theme for zsh .." 2
cat ~/.zshrc | sed 's~\(ZSH_THEME="\)[^"]*\(".*\)~\1ys\2~' > ~/.zshrc

alert "        ____  ____  _   ________   __
       / __ \/ __ \/ | / / ____/  / /
      / / / / / / /  |/ / __/    / /
     / /_/ / /_/ / /|  / /___   /_/
    /_____/\____/_/ |_/_____/  (_)
                                     " 2
