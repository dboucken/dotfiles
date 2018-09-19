#!/bin/bash

echo " "
echo "################################################################################"
echo "# Start update                                                                 #"
echo "################################################################################"

# Ask for administrator password upfront
sudo -v

# Mac specific scripts
os="$(uname -s)"

if [ "$os" == "Darwin" ]
then
    echo "Mac specific scripts."

    # Update App Store apps
    sudo softwareupdate -i -a

    # Update homebrew and cleanup
    brew update
    brew upgrade
    brew cask outdated | xargs brew cask reinstall
    brew cleanup
    brew prune
fi

# Go to dotfiles directory and push the current directory to the stack
pushd ~/dotfiles

echo " "
echo "################################################################################"
echo "# Update dotfiles                                                              #"
echo "################################################################################"

# Update dotfiles
git pull

cd ~

if [ -d "tools" ]
then
    cd ~/tools

    # Tmux must be installed
    if [ -d "tmux" ]
    then
        echo " "
        echo "################################################################################"
        echo "# Update tmux                                                                  #"
        echo "################################################################################"

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
    fi

    cd ~/tools

    if [ -d "vim" ]
    then
        echo " "
        echo "################################################################################"
        echo "# Update Vim                                                                   #"
        echo "################################################################################"

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
        if [ "$current_tag_commit" != "$latest_tag_commit" ]
        then
            make && sudo make install
        fi

        # Generate helptags for vim plugins
        vim -c 'helptags ALL' +qall

        # Cleanup and update plugins
        vim +PlugClean! +PlugUpgrade +PlugUpdate +qall
    fi
fi

# Return to the current directory
popd

echo " "
echo "################################################################################"
echo "# Update finished                                                              #"
echo "################################################################################"
