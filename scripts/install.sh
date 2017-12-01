#!/bin/bash

echo " "
echo "################################################################################"
echo "# Start install                                                                #"
echo "################################################################################"

# Ask for administrator password upfront
sudo -v

# Make sure we can execute the scripts
sudo chmod -R a+rwx ~/dotfiles

# Mac specific scripts
os="$(uname -s)"
if [ "$os" == "Darwin" ]; then
    echo "Mac specific scripts."
    sh ~/dotfiles/scripts/install/mac.sh
fi

sh ~/dotfiles/scripts/install/git-scripts.sh
sh ~/dotfiles/scripts/install/bashrc.sh
sh ~/dotfiles/scripts/install/dotfiles.sh
sh ~/dotfiles/scripts/install/tmux.sh
sh ~/dotfiles/scripts/install/vim.sh

echo " "
echo "################################################################################"
echo "# Install finished                                                             #"
echo "################################################################################"
