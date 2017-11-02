#!/bin/bash

# Update homebrew and cleanup
brew update
brew upgrade
brew cleanup
brew prune
brew cask outdated | xargs brew cask reinstall
brew cask cleanup

# Update gems
gem update

# Update npm packages
npm -g update
