#!/bin/bash

echo " "
echo "################################################################################"
echo "# Update Vim                                                                   #"
echo "################################################################################"

# Go to vim directory and push the current directory to the stack
pushd ~/tools

if [ ! -d "vim" ]; then
    echo "Vim not installed."
    # Return to the current directory
    popd
    exit
fi

cd vim

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

echo " "
echo "--------------------------------------------------------------------------------"
echo " Update Vim Plugins"
echo "--------------------------------------------------------------------------------"
vim +PlugClean! +PlugUpgrade +PlugUpdate +qall

# Return to the current directory
popd
