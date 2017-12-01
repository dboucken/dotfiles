#!/bin/bash

echo " "
echo "################################################################################"
echo "# Update dotfiles                                                              #"
echo "################################################################################"

# Go to dotfiles directory and push the current directory to the stack
pushd ~/dotfiles

# Update dotfiles
git pull

# Return to the current directory
popd
