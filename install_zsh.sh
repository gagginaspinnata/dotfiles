#!/bin/bash

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory

function say(){

    clear
    echo $1
    sleep $2
}

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
    apt-get install zsh
fi

# installing homyzsh
curl -L http://install.ohmyz.sh | sh

ln -s $dir/bash_alias ~/.oh-my-zsh/custom/alias.zsh
ln -s $dir/bash_functions ~/.oh-my-zsh/custom/functions.zsh

# If this is a mac
if [[ "$OS" == 'mac' ]]; then
    # Standard mac configuration
    ln -s $dir/osx ~/.osx
    
    #Installing home BREW
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    
    # Installing pip
    say "Installing pip" 5
    curl -sL -o $dir/pip.py https://bootstrap.pypa.io/get-pip.py
    sudo python $dir/pip.py
    rm $dir/pip.py
    
    # Installing virtualenv
    say "Installing virtualenv" 5
    sudo pip install virtualenv

    # Installing node
    say "Installing node" 5
    brew install node

    #let installing all the application without permission
    say "Let any application be installed" 5
    sudo spctl --master-disable
    
fi

#installing vundle
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

# moving vimrc files to root
ln -s $dir/vimrc ~/.vimrc

# changing the default theme
#cat ~/.zshrc | sed 's~\(ZSH_THEME="\)[^"]*\(".*\)~\1dpoggi\2~' > ~/.zshrc
#cat ~/.zshrc | sed 's/\(ZSH_THEME="\)\(.\+\)"/\1dpoggi"/' > ~/.zshrc

#setting 256 term color
echo "export TERM=xterm-256color">>~/.zshrc
echo '[ -n "$TMUX" ] && export TERM=screen-256color'>>~/.zshrc

#if we are on linux (ubuntu/debian)

echo "Remember to run sudo :PluginInstall inside vim to install nerdtree"

echo "Remember to change the zsh theme in the file .zshrc a nice one is the dpoggi"
