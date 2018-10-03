#!/bin/bash

echo " "
echo "################################################################################"
echo "# Start update                                                                 #"
echo "################################################################################"

# Ask for administrator password upfront
sudo -v

# Update App Store apps
sudo softwareupdate -i -a

# Update homebrew and cleanup
brew update
brew upgrade
brew cask upgrade --greedy
brew cleanup
brew prune

# Go to dotfiles directory and push the current directory to the stack
pushd ~/dotfiles

# Update dotfiles
git pull

# Return to the current directory
popd

echo " "
echo "################################################################################"
echo "# Update finished                                                              #"
echo "################################################################################"
