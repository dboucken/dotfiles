#!/bin/bash

echo " "
echo "################################################################################"
echo "# Install dotfiles                                                             #"
echo "################################################################################"

# Goto dotfiles directory and push the current directory to the stack
pushd ~/dotfiles

# Update dotfiles
git pull

# Link to dotfiles
cd ~
ln -sv ~/dotfiles/dotfiles/.vimrc
ln -sv ~/dotfiles/dotfiles/.tmux.conf
ln -sv ~/dotfiles/dotfiles/.inputrc

# Return to the current directory
popd
