#!/bin/sh

# Install a formula only if it is not already installed
brew_install() {
  FORMULA=$1
  brew list $FORMULA >/dev/null || brew install $FORMULA
}

# Install a cask formula only if it is not already installed
brew_cask_install() {
  FORMULA=$1
  brew list --cask $FORMULA >/dev/null || brew install --cask $FORMULA
}

# Install brew if it is not already installed
command -v brew >/dev/null 2>&1 || \
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Make sure we’re using the latest Homebrew
brew update

# Development tools
brew_install autoenv
brew_install automake
brew_cask_install cmake
brew_install direnv
brew_install gh
brew_install gist
brew_install hub
brew_cask_install intellij-idea
brew_cask_install postman
brew_install pre-commit

# Common media libraries and tools
brew_install ffmpeg
brew_install imagemagick
brew_install jpeg
brew_install tesseract
brew_install tesseract-lang

# Some essential command-line tools
brew_install autossh
brew_install ctags
brew_install jq
brew_install rsync
brew_install tree
brew_install unrar
brew_install watch
brew_install wget

# Install vim from source to make sure it compiles against brewed Python
brew_install vim --with-override-system-vi
brew_install tmux

# Can't be a cloudartisan without my cloud hammers :-)
brew_install awscli
brew_cask_install google-cloud-sdk
brew tap heroku/brew
brew_install heroku
brew_install kubectl

# Use tfenv to manage multiple versions of terraform
brew unlink terraform
brew_install tfenv

# Networking
brew_cask_install ngrok
brew_install speedtest-cli

# Nice clean fonts for development
brew_install font-meslo-for-powerline
brew_cask_install font-inconsolata-dz
brew_cask_install font-inconsolata-dz-for-powerline

# Frequently used applications
brew_cask_install iterm2
brew_cask_install google-chrome

# Share ALL the files
brew_cask_install google-drive-file-stream
brew_cask_install synology-cloud-station-drive

# Password/security
brew_cask_install 1password

# Collaboration
brew_install discord
brew_install slack
brew_install signal
brew_install telegram
brew_install whatsapp

# Virtualisation
brew_install colima
brew_cask_install docker
brew_cask_install vagrant

# Some fun
brew_cask_install kindle
brew_cask_install send-to-kindle
brew_cask_install minecraft
brew_cask_install vlc

# Command line efficiencies
brew_install bash-completion@2
brew_install brew-cask-completion
brew_install django-completion
brew_install docker-completion
brew_install maven-completion
brew_install pip-completion
brew_install tmuxinator-completion
brew_install vagrant-completion

# Remove cached downloads and outdated versions
brew cleanup
