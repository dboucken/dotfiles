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
