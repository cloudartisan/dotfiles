#!/bin/sh

# Add casks and fonts
brew tap caskroom/cask
brew tap caskroom/fonts

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade --all

# Remove cached downloads and outdated versions
brew cleanup
