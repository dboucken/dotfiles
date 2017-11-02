#!/bin/bash

echo " "
echo "################################################################################"
echo "# Update dotfiles                                                              #"
echo "################################################################################"

# Goto dotfiles directory and push the current directory to the stack
pushd ~/dotfiles

# Update dotfiles
git pull

# Return to the current directory
popd
