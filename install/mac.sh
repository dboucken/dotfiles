# Install homebrew
# /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install cask
brew tap caskroom/cask

brew update
brew upgrade

# Install packages
# brew install ruby
# brew install git
# brew install node
# brew install bash
# brew install bash-eompletion
# brew install python
# brew install python3
# brew install the_silver_searcher
# brew install cscope
# brew install ctags
# brew install markdown
# brew install openconnect

# brew cask install appcleaner
# brew cask install filezilla
# brew cask install sketchup
# brew cask install stellarium
# brew cask install docker
# brew cask install dhs
# brew cask install malwarebytes
# brew cask install oversight
# brew cask install pixum-fotowereld
# brew cask install visual-studio-code
# brew cask install wireshark

# brew cask install google-chrome
# brew cask install spotify
# brew cask install google-backup-and-sync
# brew cask install firefox
# brew cask install google-drive

# Update homebrew
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
