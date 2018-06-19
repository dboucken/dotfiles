#!/bin/bash

echo " "
echo "################################################################################"
echo "# Install dotfiles                                                             #"
echo "################################################################################"

# Go to dotfiles directory and push the current directory to the stack
pushd ~/dotfiles

# Update dotfiles
git pull

# Update submodules
git submodule update --remote --merge --recursive --init

# Link to dotfiles
cd ~
ln -sv ~/dotfiles/.vimrc
ln -sv ~/dotfiles/.tmux.conf
ln -sv ~/dotfiles/.inputrc

# Return to the current directory
popd
