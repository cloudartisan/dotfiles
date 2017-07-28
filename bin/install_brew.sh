#!/bin/sh

# Add casks and fonts
brew tap caskroom/cask
brew tap caskroom/fonts

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade --all

# Python
brew install python

# Maven/Java/Groovy (ugh)
brew tap pivotal/tap
brew install springboot
brew install maven
brew install groovy

# Build tools
brew install cmake
brew install automake
brew install autoenv

# Common libraries
brew install jpeg

# Some essential command-line tools
brew install jq
brew install tree
brew install unrar

# Install vim from source to make sure it compiles against brewed Python
brew install vim --with-override-system-vi
brew install tmux

# Can't be a cloudartisan without my cloud hammers :-)
brew install awscli
brew install terraform

# Frequently used applications
brew cask install iterm2
brew cask install google-chrome
brew cask install google-drive
brew cask install amazon-drive
brew cask install synology-cloud-station-drive
brew cask install keybase
brew cask install lastpass
brew cask install screenhero
brew cask install slack
brew cask install vagrant
brew cask install virtualbox
brew cask install kindle
brew cask install send-to-kindle
brew cask install minecraft

# Nice clean font for development
brew cask install font-inconsolata-dz
brew cask install font-inconsolata-dz-for-powerline

# Command line efficiencies
brew install bash-completion
brew install homebrew/completions/brew-cask-completion
brew install homebrew/completions/bundler-completion
brew install homebrew/completions/cap-completion
brew install homebrew/completions/django-completion
brew install homebrew/completions/docker-completion
brew install homebrew/completions/fabric-completion
brew install homebrew/completions/pip-completion
brew install homebrew/completions/vagrant-completion

# Remove cached downloads and outdated versions
brew cleanup
