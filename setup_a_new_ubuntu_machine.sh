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
rm ~/.tmux.conf
ln -s $ROOT_DIR/ubuntu/tmux.ubuntu.conf ~/.tmux.conf

# link vim configs
echo "Creating symlink to vim-related files"
mkdir -p ~/.vim/after/ftplugin
rm -f ~/.vim/vimrc
rm -f ~/.vim/after/ftplugin/python.vim
rm -f ~/.vim/after/ftplugin/java.vim
rm -f ~/.vim/after/ftplugin/c.vim
rm -f ~/.ideavimrc
rm -f ~/.config/nvim/init.vim
ln -s $SHARED_DIR/vimrc ~/.vim/vimrc
ln -s $SHARED_DIR/python.vim ~/.vim/after/ftplugin/python.vim
ln -s $SHARED_DIR/java.vim ~/.vim/after/ftplugin/java.vim
ln -s $SHARED_DIR/c.vim ~/.vim/after/ftplugin/c.vim
ln -s $SHARED_DIR/ideavimrc ~/.ideavimrc
mkdir -p ~/.config/nvim
ln -s $SHARED_DIR/init.vim ~/.config/nvim/init.vim

# link zsh configs
echo "source ~/.dotfiles/shared/zshrc" >> ~/.zshrc 
rm ~/.sh_aliases
ln -s $SHARED_DIR/sh_aliases ~/.sh_aliases
