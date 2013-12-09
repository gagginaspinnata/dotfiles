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

curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

cp $dir/bash_alias ~/.oh-my-zsh/custom/alias.zsh
cp $dir/bash_functions ~/.oh-my-zsh/custom/functions.zsh

if [[ "$OS" == 'mac' ]]; then
    ln -s $dir/osx ~/.osx
fi

# moving vimrc files to root
ln -s $dir/vimrc ~/.vimrc

# changing the default theme
#cat ~/.zshrc | sed 's~\(ZSH_THEME="\)[^"]*\(".*\)~\1ys\2~' > ~/.zshrc

#setting 256 term color
echo "export TERM=xterm-256color">>~/.zshrc
echo '[ -n "$TMUX" ] && export TERM=screen-256color'>>~/.zshrc
