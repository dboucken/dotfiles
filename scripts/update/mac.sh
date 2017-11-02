#!/bin/bash

# Update App Store apps
sudo softwareupdate -i -a

# Update homebrew and cleanup
brew update
brew upgrade
brew cleanup
brew prune
brew cask outdated | xargs brew cask reinstall
brew cask cleanup

# Update gems
gem update

# Update npm and npm packages
npm install npm -g
npm update -g
