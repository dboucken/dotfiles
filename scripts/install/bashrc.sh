#!/bin/bash

echo " "
echo "################################################################################"
echo "# Install bashrc                                                               #"
echo "################################################################################"

# Goto home directory and push the current directory to the stack
pushd ~

# Source the repository bashrc in the correct home directory bashrc or bash_profile file
echo source ~/dotfiles/dotfiles/.bashrc >> ~/.bashrc
echo "Append repository .bashrc to home directory .bashrc"

# Return to the current directory
popd

