#!/bin/bash

echo " "
echo "################################################################################"
echo "# Start uninstallation                                                         #"
echo "################################################################################"

cd ~

sh ~/dotfiles/uninstall/dotfiles.sh
sh ~/dotfiles/uninstall/git-scripts.sh

if [ -d "tools" ]; then
    cd tools

    sh ~/dotfiles/uninstall/tmux.sh
    sh ~/dotfiles/uninstall/vim.sh

    cd ~

    rm -vrf tools
fi

echo " "
echo "################################################################################"
echo "# Uninstallation finished                                                      #"
echo "################################################################################"
