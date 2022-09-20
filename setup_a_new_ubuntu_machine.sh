#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables
ROOT_DIR=~/.dotfiles                    # dotfiles directory
SHARED_DIR=~/.dotfiles/shared           # dotfiles directory
VIM_DIR=~/.vim
##########

# change to the dotfiles directory
echo "Changing to the $ROOT_DIR directory"
cd $ROOT_DIR
echo "...done"

# link tmux configs
echo "Creating symlink to tmux-related files"
ln -s $ $ROOT_DIR/ubuntu/tmux.ubuntu.conf ~/.tmux.conf

# link vim configs
echo "Creating symlink to vim-related files"
mkdir -p ~/.vim/after/ftplugin
ln -s $SHARED_DIR/vimrc ~/.vim/
ln -s $SHARED_DIR/python.vim ~/.vim/after/ftplugin
ln -s $SHARED_DIR/java.vim ~/.vim/after/ftplugin
ln -s $SHARED_DIR/c.vim ~/.vim/after/ftplugin
ln -s $SHARED_DIR/ideavimrc ~/.ideavimrc

# link zsh configs
echo "source ~/.dotfiles/shared/zshrc" >> ~/.zshrc 
ln -s $SHARED_DIR/sh_aliases ~/.sh_aliases
