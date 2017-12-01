#!/bin/bash

# This script installs vim in the tools directory, make sure the dependencies to build and install
# vim are installed
echo " "
echo "################################################################################"
echo "# Install Vim                                                                  #"
echo "################################################################################"

# Try create tools directory for case that it does not already exists
mkdir ~/tools 2> /dev/null

# Go to tools directory and push the current directory to the stack
pushd ~/tools

# Vim may not be installed already
if [ -d "vim" ]; then
    echo "Vim already installed."
    # Return to the current directory
    popd
    exit
fi

# Clone the vim repository
git clone https://github.com/vim/vim.git vim

cd vim

# Configure, build and install vim
./configure --with-features=huge && make && chmod a+rwx runtime/doc && sudo make install

echo " "
echo "--------------------------------------------------------------------------------"
echo " Install Vim Plugins"
echo "--------------------------------------------------------------------------------"
vim +PlugUpdate +PlugUpgrade +qall

# Return to the current directory
popd
