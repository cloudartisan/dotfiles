#!/bin/sh

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

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
brew install direnv

# Configuration tools
brew install ansible
brew install ansible-lint

# Common libraries
brew install jpeg

# Some essential command-line tools
brew install jq
brew install tree
brew install unrar
brew install wget

# Install vim from source to make sure it compiles against brewed Python
brew install vim --with-override-system-vi
brew install tmux

# Can't be a cloudartisan without my cloud hammers :-)
brew install awscli
brew cask install google-cloud-sdk
brew install terraform
brew install kubectl

# Nice clean font for development
brew cask install font-inconsolata-dz
brew cask install font-inconsolata-dz-for-powerline

# Frequently used applications
brew cask install iterm2
brew cask install google-chrome

# Share ALL the files
brew cask install google-drive
brew cask install amazon-drive
brew cask install odrive
brew cask install synology-cloud-station-drive

# Password/security
brew cask install keybase
brew cask install lastpass

# Collaboration
brew cask install screenhero
brew cask install slack

# Virtualisation
brew cask install docker
brew cask install vagrant
brew cask install virtualbox

# Some fun
brew cask install kindle
brew cask install send-to-kindle
brew cask install minecraft
brew cask install vlc

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
