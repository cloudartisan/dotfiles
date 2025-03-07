#!/bin/bash

# Script to bootstrap a new system with chezmoi and dotfiles

# Detect OS
if [ "$(uname)" = "Darwin" ]; then
  echo "Detected macOS system"
  
  # Install Homebrew if not already installed
  if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  
  # Install chezmoi with Homebrew
  brew install chezmoi
else
  echo "Detected Linux system"
  
  # Direct installation of chezmoi on Linux
  sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/bin
fi

# Initialize chezmoi with the dotfiles repository
if [ "$1" = "--apply" ]; then
  echo "Initializing and applying chezmoi configuration..."
  chezmoi init --apply https://github.com/cloudartisan/dotfiles.git
  
  # Ensure all dotfiles are properly managed
  echo "Adding configuration files to chezmoi..."
  
  # Add all bash configuration files except .bash_history
  for bash_file in ~/.bash_*; do
    if [ -f "$bash_file" ] && [ "$(basename "$bash_file")" != ".bash_history" ]; then
      chezmoi add "$bash_file"
    fi
  done
  
  # Make sure .bash_profile is executable
  chezmoi chmod 755 ~/.bash_profile
  
  # Add other common dotfiles
  dotfiles=(
    ~/.gitconfig
    ~/.gemrc
    ~/.irbrc
    ~/.hgrc
    ~/.hgignore
    ~/.screenrc
    ~/.tmux.conf
    ~/.tmux_tmuxline.conf
    ~/.iterm2_shell_integration.bash
    ~/.fog
    ~/.ruby-version
  )
  
  for dotfile in "${dotfiles[@]}"; do
    if [ -f "$dotfile" ]; then
      echo "Adding $dotfile to chezmoi..."
      chezmoi add "$dotfile"
    fi
  done
  
  # Add dot directories with special handling
  
  # .ssh directory (needs private_ prefix for permissions)
  if [ -d ~/.ssh ]; then
    echo "Adding ~/.ssh to chezmoi with private_ prefix..."
    chezmoi add --encrypt=false --template=false --private ~/.ssh
  fi
  
  # .iterm2 directory
  if [ -d ~/.iterm2 ]; then
    echo "Adding ~/.iterm2 to chezmoi..."
    chezmoi add ~/.iterm2
  fi
  
  # .tmuxinator directory
  if [ -d ~/.tmuxinator ]; then
    echo "Adding ~/.tmuxinator to chezmoi..."
    chezmoi add ~/.tmuxinator
  fi
  
  # Apply the changes
  chezmoi apply
else
  echo "Initializing chezmoi configuration (without applying)..."
  echo "Review changes with 'chezmoi diff' and apply with 'chezmoi apply'"
  chezmoi init https://github.com/cloudartisan/dotfiles.git
  
  echo "To manage your dotfiles with chezmoi, you can run:"
  echo "# Add all bash configuration files"
  echo "for bash_file in ~/.bash_*; do chezmoi add \"\$bash_file\"; done"
  echo ""
  echo "# Add other dotfiles"
  echo "chezmoi add ~/.gitconfig ~/.gemrc ~/.irbrc ~/.tmux.conf ~/.tmux_tmuxline.conf ~/.hgrc ~/.hgignore ~/.fog ~/.ruby-version ~/.screenrc ~/.iterm2_shell_integration.bash"
  echo ""
  echo "# Add directories with special permissions"
  echo "chezmoi add --encrypt=false --template=false --private ~/.ssh"
  echo "chezmoi add ~/.iterm2 ~/.tmuxinator"
fi

echo "Bootstrap complete!"
