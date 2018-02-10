#!/bin/bash

sudo xcodebuild -license accept

# Install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install cask
brew tap caskroom/cask

brew update
brew upgrade

# Install packages
brew install git
brew install bash
brew install bash-completion
brew install python3
brew install cscope
brew install ctags
brew install markdown
brew install openconnect
brew install wget
brew install automake
brew install pkg-config
brew install libevent
brew install ripgrep

brew cask install appcleaner
brew cask install filezilla
brew cask install sketchup
brew cask install stellarium
brew cask install docker
brew cask install dhs
brew cask install malwarebytes
brew cask install oversight
brew cask install pixum-fotowereld

# brew cask install google-chrome
# brew cask install spotify
# brew cask install google-backup-and-sync

# Update homebrew and cleanup
brew update
brew upgrade
brew cleanup
brew cask cleanup
brew prune
