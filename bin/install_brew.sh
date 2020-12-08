#!/bin/sh

# Install a formula only if it is not already installed
brew_install() {
  FORMULA=$1
  brew list $FORMULA >/dev/null || brew install $FORMULA
}

# Install a cask formula only if it is not already installed
brew_cask_install() {
  FORMULA=$1
  brew cask list $FORMULA >/dev/null || brew cask install $FORMULA
}

# Install brew if it is not already installed
command -v brew >/dev/null 2>&1 || \
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Make sure we’re using the latest Homebrew
brew update

# Add casks and fonts
brew tap homebrew/cask-cask
brew tap homebrew/cask-fonts

# Development tools
brew_install gh
brew_install gist
brew_install hub
brew_cask_install intellij-idea
brew_cask_install postman
brew_install pre-commit

# Python
PYTHON_CONFIGURE_OPTS="--enable-framework" \
  brew_install pyenv && \
  pyenv install 3.8.6 && \
  pyenv global 3.8.6

# Maven/Java/Groovy (ugh)
brew tap pivotal/tap
brew_install springboot
brew_install maven
brew_install groovy

# Build tools
brew_install cmake
brew_install automake
brew_install autoenv
brew_install direnv

# Configuration tools
brew_install ansible
brew_install ansible-lint

# Common media libraries and tools
brew_install ffmpeg
brew_install imagemagick
brew_install jpeg
brew_install tesseract
brew_install tesseract-lang

# Some essential command-line tools
brew_install ctags
brew_install jq
brew_install tree
brew_install unrar
brew_install watch
brew_install wget

# Install vim from source to make sure it compiles against brewed Python
brew_install vim --with-override-system-vi
brew_install tmux

# Install the oni editor
brew cask install oni

# Can't be a cloudartisan without my cloud hammers :-)
brew_install awscli
brew_cask_install google-cloud-sdk
brew tap heroku/brew
brew_install heroku
brew_install kubectl

# Use tfswitch to manage multiple versions of terraform
brew unlink terraform
brew_install warrensbox/tap/tfswitch

# Networking
brew_cask_install ngrok
brew_install speedtest-cli

# Nice clean font for development
brew_cask_install font-inconsolata-dz
brew_cask_install font-inconsolata-dz-for-powerline

# Frequently used applications
brew_cask_install iterm2
brew_cask_install google-chrome

# Share ALL the files
brew_cask_install google-drive-file-stream
brew_cask_install amazon-drive
brew_cask_install odrive
brew_cask_install synology-cloud-station-drive

# Password/security
brew_cask_install keybase
brew_cask_install lastpass

# Collaboration
brew_cask_install skype
brew_cask_install slack
brew_cask_install telegram

# Virtualisation
brew_cask_install docker
brew_cask_install vagrant
brew_cask_install virtualbox

# Some fun
brew_cask_install kindle
brew_cask_install send-to-kindle
brew_cask_install minecraft
brew_cask_install vlc

# Command line efficiencies
brew_install bash-completion
brew_install homebrew/completions/brew-cask-completion
brew_install homebrew/completions/bundler-completion
brew_install homebrew/completions/cap-completion
brew_install homebrew/completions/django-completion
brew_install homebrew/completions/docker-completion
brew_install homebrew/completions/fabric-completion
brew_install homebrew/completions/pip-completion
brew_install homebrew/completions/vagrant-completion

# Remove cached downloads and outdated versions
brew cleanup
