#!/bin/bash

echo " "
echo "################################################################################"
echo "# Update tmux                                                                  #"
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

# Get current version
current_tag=$(git describe --tags --abbrev=0)
current_tag_commit=$(git rev-list -n 1 $current_tag)
echo "Current tag: $current_tag ($current_tag_commit)"

# Update repository
git checkout master
git pull

# Get new version
latest_tag=$(git describe --tags --abbrev=0)
git checkout $latest_tag &>/dev/null
latest_tag_commit=$(git rev-list -n 1 $latest_tag)
echo "Latest tag: $latest_tag ($latest_tag_commit)"

# Build and install if there is a new version
if [ "$current_tag_commit" != "$latest_tag_commit" ]; then
    make && sudo make install
fi

# Return to the current directory
popd
