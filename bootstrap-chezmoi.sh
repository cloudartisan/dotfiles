#!/bin/bash

# Bootstrap script for dotfiles using chezmoi
# Usage: ./bootstrap-chezmoi.sh [--apply]

set -e

echo "🚀 Bootstrapping dotfiles with chezmoi..."

# Detect OS and install chezmoi
if [ "$(uname)" = "Darwin" ]; then
  echo "📱 Detected macOS"
  
  # Install Homebrew if not present
  if ! command -v brew &> /dev/null; then
    echo "🍺 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  
  # Install chezmoi
  if ! command -v chezmoi &> /dev/null; then
    echo "📦 Installing chezmoi..."
    brew install chezmoi
  fi
else
  echo "🐧 Detected Linux"
  
  # Install chezmoi
  if ! command -v chezmoi &> /dev/null; then
    echo "📦 Installing chezmoi..."
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/bin"
    export PATH="$HOME/bin:$PATH"
  fi
fi

# Initialize and apply dotfiles
if [ "$1" = "--apply" ]; then
  echo "⚡ Initializing and applying dotfiles..."
  chezmoi init --apply https://github.com/cloudartisan/dotfiles.git
else
  echo "🔍 Initializing dotfiles (preview mode)..."
  chezmoi init https://github.com/cloudartisan/dotfiles.git
  echo ""
  echo "Preview changes with: chezmoi diff"
  echo "Apply changes with:   chezmoi apply"
fi

echo "✅ Bootstrap complete!"