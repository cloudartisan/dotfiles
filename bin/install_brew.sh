#!/bin/sh

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade --all

# Latest Python and some other build tools
brew install python
brew install automake
brew install cmake

# Install vim from source to make sure it compiles against brewed Python
brew install vim --with-override-system-vi
brew install tmux

# Can't be a cloudartisan without my cloud hammers :-)
brew install awscli
brew install terraform

# Frequently used applications
brew tap caskroom/cask
brew cask
brew cask install iterm2
brew cask install google-chrome
brew cask install google-drive
brew cask install amazon-drive
brew cask install synology-cloud-station-drive
brew cask install lastpass
brew cask install screenhero
brew cask install slack
brew cask install kindle
brew cask install send-to-kindle
brew cask install minecraft

# Remove outdated versions from the cellar.
brew cleanup
