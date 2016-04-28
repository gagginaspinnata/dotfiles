#!/bin/bash

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory



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

if [[ "$OS" == 'mac' ]]; then
    ln -s $dir/osx ~/.osx
fi

#installing vundle
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

# moving vimrc files to root
ln -s $dir/vimrc ~/.vimrc

# changing the default theme
#cat ~/.zshrc | sed 's~\(ZSH_THEME="\)[^"]*\(".*\)~\1dpoggi\2~' > ~/.zshrc
cat ~/.zshrc | sed 's/\(ZSH_THEME="\)\(.\+\)"/\1dpoggi"/' > ~/.zshrc

#setting 256 term color
echo "export TERM=xterm-256color">>~/.zshrc
echo '[ -n "$TMUX" ] && export TERM=screen-256color'>>~/.zshrc

echo "Remember to run sudo :PluginInstall inside vim to install nerdtree"

echo "Remember to change the zsh theme in the file .zshrc a nice one is the dpoggi"
