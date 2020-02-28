#!/bin/bash

# VIM
echo '-> Setting up Vim'
if [ -e "~/.vimrc" ]
then
    echo '    -> .vimrc exists, moving to .vimrc2'
    mv ~/.vimrc ~/.vimrc2
fi
cp $(pwd)/.vimrc ~/.vimrc
sudo apt-get install -y vim-gnome
sudo apt-get install -y build-essential cmake
sudo apt-get install -y python-dev
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
python ~/.vim/bundle/YouCompleteMe/install.py
chown -R $USER ~/.vim
 
# Bash
echo "-> Linking .bashrc into home directory"
if [ -e "~/.bash_aliases" ]
then
    echo '    -> .bash_aliases exists, moving to .bash_aliases2'
    mv ~/.bashaliases ~/.bash_aliases2
fi
ln -s $(pwd)/.bash_aliases ~/.bash_aliases

source ~/.bashrc
