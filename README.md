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

## Maintaining Your Dotfiles

### Daily Workflow

1. **Making changes to your dotfiles:**

   When you want to update a configuration file (e.g., `.bashrc`, `.vimrc`):

   ```bash
   # Edit the file directly with the chezmoi edit command
   chezmoi edit ~/.bashrc
   
   # Apply the changes immediately
   chezmoi apply
   ```

   Alternatively, you can:

   ```bash
   # Edit the file directly in your home directory
   vim ~/.bashrc
   
   # Add the changes to chezmoi's source state
   chezmoi add ~/.bashrc
   ```

2. **Viewing changes before applying:**

   ```bash
   # See what changes would be made
   chezmoi diff
   ```

3. **Adding new dotfiles to be managed:**

   ```bash
   # Add any new file to be managed by chezmoi
   chezmoi add ~/.my_new_config
   ```

4. **Keeping your systems in sync:**

   ```bash
   # On other machines, pull the latest changes and apply them
   chezmoi update
   ```

### Repository Management

To maintain this repository:

1. **Commit your changes regularly:**

   ```bash
   # Go to the chezmoi source directory
   cd ~/.local/share/chezmoi
   
   # Add and commit changes
   git add .
   git commit -m "Update bash aliases"
   git push
   ```

   Or use the built-in chezmoi commands:

   ```bash
   # Add and commit changes from anywhere
   chezmoi cd -- git add .
   chezmoi cd -- git commit -m "Update bash aliases"
   chezmoi cd -- git push
   ```

2. **Adding new Homebrew packages:**

   Update the Brewfile and commit it:

   ```bash
   # Add a new package to Brewfile
   chezmoi edit ~/Brewfile
   
   # Test the changes
   brew bundle --file=~/Brewfile
   
   # Add the changes to chezmoi
   chezmoi add ~/Brewfile
   ```

3. **Ignore sensitive files:**

   Edit .chezmoiignore to exclude sensitive files:

   ```bash
   chezmoi edit ~/.local/share/chezmoi/.chezmoiignore
   ```

### Best Practices

- Keep sensitive information out of your dotfiles repository (use templates or external secrets managers)
- Always review changes with `chezmoi diff` before applying
- Regularly update your repository with `chezmoi update`
- Use templates for machine-specific configurations
- Be careful with SSH keys and credentials - use `private_` prefix for sensitive files

## License

MIT
