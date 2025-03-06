# Dotfiles

Personal dotfiles and configuration files managed with [chezmoi](https://www.chezmoi.io/).

## Quick Start

To set up a new machine:

```bash
# One-step bootstrap (review first)
curl -fsLS https://raw.githubusercontent.com/cloudartisan/dotfiles/master/bootstrap-chezmoi.sh | bash

# Or apply immediately
curl -fsLS https://raw.githubusercontent.com/cloudartisan/dotfiles/master/bootstrap-chezmoi.sh | bash -s -- --apply
```

## Features

- Shell configuration (bash & zsh support)
- Git configuration
- Vim setup with plugins
- Tmux configuration
- Homebrew package management
- Supports both macOS and Linux

## Manual Installation

```bash
# Install chezmoi
brew install chezmoi  # macOS
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/bin  # Linux

# Initialize from repo and apply
chezmoi init https://github.com/cloudartisan/dotfiles.git
chezmoi diff  # Review changes
chezmoi apply  # Apply changes
```

## Structure

- `.chezmoiscripts/` - Scripts that run when applying the config
- `bin/` - Utility scripts
- `dot_*` - Regular dotfiles (e.g., dot_bashrc → .bashrc)
- `executable_*` - Files with executable permissions
- `private_*` - Files with stricter permissions (600)

## Migration from Traditional Dotfiles

This repository was migrated from a traditional dotfiles setup to chezmoi. For migration details, see [migrate-to-chezmoi.md](migrate-to-chezmoi.md).

## License

MIT
