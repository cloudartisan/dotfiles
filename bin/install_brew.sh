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

brew cask
brew cask install iterm2
brew cask install google-chrome

# Remove outdated versions from the cellar.
brew cleanup
