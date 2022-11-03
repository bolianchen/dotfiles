#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables
ROOT_DIR=~/.dotfiles                    # dotfiles directory
VIM_DIR=~/.vim
##########

# change to the dotfiles directory
echo "Changing to the $ROOT_DIR directory"
cd $ROOT_DIR
echo "...done"

# link tmux configs
echo "Creating symlink to tmux-related files"
rm ~/.tmux.conf
ln -s $ROOT_DIR/tmux.conf ~/.tmux.conf

# link vim configs
echo "Creating symlink to vim-related files"
mkdir -p $VIM_DIR/after/ftplugin
rm -f $VIM_DIR/vimrc
rm -f $VIM_DIR/after/ftplugin/python.vim
rm -f $VIM_DIR/after/ftplugin/java.vim
rm -f $VIM_DIR/after/ftplugin/c.vim
rm -f ~/.ideavimrc
rm -f ~/.config/nvim/init.vim
ln -s $ROOT_DIR/vimrc $VIM_DIR/vimrc
ln -s $ROOT_DIR/python.vim $VIM_DIR/after/ftplugin/python.vim
ln -s $ROOT_DIR/java.vim $VIM_DIR/after/ftplugin/java.vim
ln -s $ROOT_DIR/c.vim $VIM_DIR/after/ftplugin/c.vim
ln -s $ROOT_DIR/ideavimrc ~/.ideavimrc
mkdir -p ~/.config/nvim
ln -s $ROOT_DIR/init.vim ~/.config/nvim/init.vim

# link zsh configs
echo "source $ROOT_DIR/zshrc" >> ~/.zshrc 
rm -f ~/.sh_aliases
ln -s $ROOT_DIR/sh_aliases ~/.sh_aliases
