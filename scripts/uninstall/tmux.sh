#!/bin/bash

echo " "
echo "################################################################################"
echo "# Uninstall Tmux                                                               #"
echo "################################################################################"

# Go to tmux directory and push the current directory to the stack
pushd ~/tools

# Tmux must be installed
if [ ! -d "tmux" ]; then
    echo "Tmux not installed."
    # Return to the current directory
    popd
    exit
fi

cd tmux

# Uninstall
sudo make uninstall

# Remove directory
rm -rf ~/tools/tmux

# Remove tmux related directories and files in the home directory
rm -rf ~/.tmux

# Return to the current directory
popd
