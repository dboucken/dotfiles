#!/bin/bash

tools_dir="tools"
tmux_dir="tmux"
vim_dir="vim"

cd ~

# Tools directory must exist
if [ ! -d "$tools_dir" ]; then
    echo "~/$tools_dir not found"
    return
fi

if [ ! -d "dotfiles" ]; then
    echo "dotfiles not found"
    return
fi

echo " "
echo "################################################################################"
echo "# Update dotfiles                                                              #"
echo "################################################################################"
cd dotfiles
git pull
cd ~
if [ -f ".bash_profile" ]; then
    source .bash_profile
fi
if [ -f ".bashrc" ]; then
    source .bashrc
fi

cd $tools_dir

if [ -d "$tmux_dir" ]; then
    echo " "
    echo "################################################################################"
    echo "# Update Tmux                                                                  #"
    echo "################################################################################"
    cd $tmux_dir

    # Get current version
    current_tag=$(git describe --tags --abbrev=0)
    echo "Current tag: $current_tag"

    # Update repo
    git checkout master
    git pull

    # Get new version
    latest_tag=$(git describe --tags --abbrev=0)
    echo "Latest tag: $latest_tag"
    git checkout $latest_tag

    # Build and install if there is a new version
    if [ "$current_tag" != "$latest_tag" ]; then
        make && sudo make install
    fi
fi

cd ~
cd $tools_dir

if [ -d "$vim_dir" ]; then
    echo " "
    echo "################################################################################"
    echo "# Update Vim                                                                   #"
    echo "################################################################################"
    cd $vim_dir

    # Get current version
    current_tag=$(git describe --all)
    echo "Current tag: $current_tag"

    # Update repo
    git pull

    # Get new version
    latest_tag=$(git describe --all)
    echo "Latest tag: $latest_tag"

    # Build and install if there is a new version
    if [ "$current_tag" != "$latest_tag" ]; then
        make && sudo make install
    fi

    echo " "
    echo "--------------------------------------------------------------------------------"
    echo " Update Vim Plugins (vim +PlugUpdate +PlugUpgrade +qall)"
    echo "--------------------------------------------------------------------------------"
    vim +PlugUpdate +PlugUpgrade +qall
fi

cd ~

echo " "
echo "################################################################################"
echo "# Update finished                                                              #"
echo "################################################################################"
