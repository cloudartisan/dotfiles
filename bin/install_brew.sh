#!/bin/sh

# Install brew if it is not already installed
command -v brew >/dev/null 2>&1 || \
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Make sure we're using the latest Homebrew
brew update

# Install required taps
brew tap homebrew/bundle
brew tap homebrew/cask-fonts

# Install all dependencies using Brewfile
brew bundle --file="$HOME/git/cloudartisan/dotfiles/Brewfile"

# Remove cached downloads and outdated versions
brew cleanup