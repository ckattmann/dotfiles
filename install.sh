#!/bin/bash

# VIM
echo '-> Setting up Vim'
if [ -e "~/.vimrc" ]
then
    echo '    -> .vimrc exists, moving to .vimrc2'
    mv ~/.vimrc ~/.vimrc2
fi
cp $(pwd)/.vimrc ~/.vimrc
sudo apt-get install -y vim
sudo apt-get install -y build-essential cmake
sudo apt-get install -y python-dev
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

vim +PluginInstall +qall
