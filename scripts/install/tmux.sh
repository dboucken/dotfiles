#!/bin/bash

# This script installs tmux in the tools directory, make sure the dependencies to build and install
# tmux are installed
echo " "
echo "################################################################################"
echo "# Install tmux                                                                 #"
echo "################################################################################"

# Try create tools directory for case that it does not already exists
mkdir ~/tools 2> /dev/null

# Go to tools directory and push the current directory to the stack
pushd ~/tools

# Tmux may not be installed already
if [ -d "tmux" ]; then
    echo "Tmux already installed."
    # Return to the current directory
    popd
    exit
fi

# Clone the tmux repository
git clone https://github.com/tmux/tmux.git tmux

cd tmux

# Use latest tag
latest_tag=$(git describe --tags --abbrev=0)
git checkout $latest_tag

# Configure, build and install
sh autogen.sh && ./configure && make && sudo make install

# Return to the current directory
popd
