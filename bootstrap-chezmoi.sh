#!/bin/bash

# Bootstrap script for dotfiles using chezmoi
#
# Usage:
#   ./bootstrap-chezmoi.sh [--apply]
#
# If run from inside a local checkout of the dotfiles repository, that
# checkout is configured as the chezmoi source directory. Otherwise the
# repository is cloned from GitHub to ~/.local/share/chezmoi.

set -e

echo "Bootstrapping dotfiles with chezmoi..."

# Detect OS and install chezmoi
if [ "$(uname)" = "Darwin" ]; then
  echo "Detected macOS"

  # Install Homebrew if not present
  if ! command -v brew &> /dev/null; then
    if [ -x /opt/homebrew/bin/brew ] || [ -x /usr/local/bin/brew ]; then
      echo "Homebrew installed but not on PATH"
    else
      echo "Installing Homebrew..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    # The installer does not modify PATH; do it for this script.
    # Future shells get the PATH from ~/.zsh/homebrew.zsh once applied.
    if [ -x /opt/homebrew/bin/brew ]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"   # Apple Silicon
    elif [ -x /usr/local/bin/brew ]; then
      eval "$(/usr/local/bin/brew shellenv)"      # Intel
    fi
  fi

  # Install chezmoi
  if ! command -v chezmoi &> /dev/null; then
    echo "Installing chezmoi..."
    brew install chezmoi
  fi
else
  echo "Detected Linux"

  # Install chezmoi
  if ! command -v chezmoi &> /dev/null; then
    echo "Installing chezmoi..."
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/bin"
    export PATH="$HOME/bin:$PATH"
  fi
fi

# If this script lives inside a checkout of the dotfiles repository, use
# that checkout as the chezmoi source instead of cloning a second copy
script_dir="$(cd "$(dirname "$0")" && pwd)"
if [ -f "$script_dir/.chezmoiignore" ] && [ -d "$script_dir/.chezmoiscripts" ]; then
  echo "Using local checkout as chezmoi source: $script_dir"
  mkdir -p "$HOME/.config/chezmoi"
  if [ ! -f "$HOME/.config/chezmoi/chezmoi.toml" ]; then
    printf 'sourceDir = "%s"\n' "$script_dir" > "$HOME/.config/chezmoi/chezmoi.toml"
  fi
  if [ "$1" = "--apply" ]; then
    echo "Applying dotfiles..."
    chezmoi apply
  else
    echo "Preview changes with: chezmoi diff"
    echo "Apply changes with:   chezmoi apply"
  fi
else
  # No local checkout; clone from GitHub
  if [ "$1" = "--apply" ]; then
    echo "Initializing and applying dotfiles..."
    chezmoi init --apply https://github.com/cloudartisan/dotfiles.git
  else
    echo "Initializing dotfiles (preview mode)..."
    chezmoi init https://github.com/cloudartisan/dotfiles.git
    echo ""
    echo "Preview changes with: chezmoi diff"
    echo "Apply changes with:   chezmoi apply"
  fi
fi

echo "Bootstrap complete!"
