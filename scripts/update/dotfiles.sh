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
git submodule update --remote --init

# Return to the current directory
popd
