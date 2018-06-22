#!/bin/bash

echo " "
echo "################################################################################"
echo "# Update dotfiles                                                              #"
echo "################################################################################"

# Go to dotfiles directory and push the current directory to the stack
pushd ~/dotfiles

# Update dotfiles
git pull

# Update submodules
git submodule update --remote --merge --recursive --init
git add vim
git commit -m 'Update submodules'

# Return to the current directory
popd
