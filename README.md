# Dotfiles

Personal dotfiles and configuration files managed with [chezmoi](https://www.chezmoi.io/).

## Quick Start

To set up a new machine (one command does everything):

```bash
curl -fsLS https://raw.githubusercontent.com/cloudartisan/dotfiles/master/bootstrap-chezmoi.sh | bash -s -- --apply
```

This will:
- Install chezmoi
- Clone and apply your dotfiles
- Install Homebrew and all packages
- Set up Vim, Git, shell configuration
- Install Cursor Agent CLI
- Configure everything automatically

## Features

- Shell configuration (bash & zsh support)
- Git configuration
- Vim setup with plugins
- Tmux configuration
- Homebrew package management
- Cursor Agent CLI integration
- Supports both macOS and Linux

## Daily Usage

After initial setup, use these commands:

```bash
# Update all machines with latest changes
chezmoi update

# Edit a dotfile
chezmoi edit ~/.bash_profile

# Apply changes locally
chezmoi apply

# Commit and push changes
chezmoi cd -- git add . && git commit -m "Update config" && git push
```

## Structure

- `.chezmoiscripts/` - Scripts that run when applying the config
- `bin/` - Utility scripts
- `dot_*` - Regular dotfiles (e.g., dot_bashrc → .bashrc)
- `executable_*` - Files with executable permissions
- `private_*` - Files with stricter permissions (600)

## Available Commands

After installation, you'll have access to these utility scripts:

### Manual Installation & Setup
- `install_brew` - Install Homebrew and packages from Brewfile  
- `install_vim` - Set up Vim with plugins and configuration
- `install_cursor_agent` - Install Cursor AI agent CLI tool (utility)
- `install_tmux` - Install and configure tmux

### Maintenance
- `upgrade_brew` - Update Homebrew and all packages
- `update_vim` - Update Vim plugins
- `setup_hugo_completion` - Set up Hugo bash completion

### Git Utilities
- `git-ignore` - Add files to .gitignore
- `git-author-rewrite.sh` - Rewrite commit author history
- `git-repull-ship.bash` - Git workflow helper

### System Utilities
- `ps-rss`, `ps-priv-dirty-rss` - Memory usage tools
- `gettarz`, `subvertarz` - Archive utilities
- `vidslurp` - Video processing tool

## Automated Setup Scripts

This repository includes automated setup scripts that run when applying the configuration:

### What the Scripts Do

- **Package Installation**: Installs Homebrew and all packages from Brewfile
- **Vim Setup**: Configures Vim with plugins from the dotvim repository
- **Shell Configuration**: Sets up bash shell with helpful aliases
- **Cursor Agent**: Installs and configures Cursor AI agent CLI tool
- **Git Setup**: Configures Git with user information and useful aliases
- **macOS Settings**: Configures macOS preferences (only on macOS)

### How the Scripts Work

- Scripts are located in the `.chezmoiscripts/` directory
- They run automatically when you execute `chezmoi apply`
- The `run_once_` prefix ensures they only run once per machine
- Scripts use templating to customize configurations for different machines

### Using Templates for Different Machines

Some scripts use templating to provide different settings for work vs. personal machines:

```bash
# The script will prompt you when setting up a new machine
{{- if (eq .chezmoi.hostname "work-laptop") }}
# Work-specific settings
{{- else }}
# Personal settings
{{- end }}
```

## Migration from Traditional Dotfiles

This repository was migrated from a traditional dotfiles setup to chezmoi. For migration details, see [migrate-to-chezmoi.md](migrate-to-chezmoi.md).

## How This Repository Works

### The Source of Truth

**The GitHub repository is the authoritative source of truth for your dotfiles.**

All your dotfiles are version-controlled in this repository. When you make changes through chezmoi, they are:
1. Saved in your GitHub repository
2. Applied to your local system
3. Available to sync to other machines

### Simple Workflow

```bash
# 1. Edit a dotfile
chezmoi edit ~/.bash_profile

# 2. Apply the changes to your home directory
chezmoi apply

# 3. Commit and push to GitHub
chezmoi cd -- git commit -m "Update bash profile" && git push
```

That's it! Your changes are now tracked and synchronized.

### Where Everything Lives

- **GitHub repository**: The master copy of your dotfiles
- **~/.local/share/chezmoi**: Local copy of the repository 
- **Your home directory (~)**: Where the actual dotfiles are used by your system

### Step-by-Step Guide

#### Editing Existing Dotfiles

Method 1 (Recommended):
```bash
# Edit through chezmoi (this is the best way)
chezmoi edit ~/.bashrc

# Apply changes to your home directory
chezmoi apply

# Commit and push
chezmoi cd -- git commit -m "Update bashrc" && git push
```

Method 2:
```bash
# Edit directly
vim ~/.bashrc

# Add changes to chezmoi
chezmoi add ~/.bashrc

# Apply changes
chezmoi apply

# Commit and push
chezmoi cd -- git commit -m "Update bashrc" && git push
```

#### Adding New Dotfiles

```bash
# Add a new config file
chezmoi add ~/.my_new_config

# Commit and push
chezmoi cd -- git commit -m "Add new config" && git push
```

#### Setting Up a New Machine

```bash
# One command to install chezmoi and apply your dotfiles
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply cloudartisan
```

This will:
1. Install chezmoi
2. Clone your dotfiles repository
3. Run all the automated setup scripts
4. Configure your shell, Vim, Git, and other tools
5. Install packages from Brewfile (via the run_once scripts)

#### Keeping Multiple Machines in Sync

After you've pushed changes from one machine:

```bash
# On your other machines:
chezmoi update
```

This pulls the latest changes from GitHub and applies them.

### Essential Commands

- `chezmoi edit ~/.file` - Edit a dotfile
- `chezmoi add ~/.file` - Track a new file
- `chezmoi diff` - Preview changes before applying
- `chezmoi apply` - Apply changes to your home directory
- `chezmoi update` - Pull and apply latest changes from GitHub
- `chezmoi cd -- git command` - Run git commands in the repository

### Best Practices

- Always use `chezmoi edit` instead of editing files directly
- Review changes with `chezmoi diff` before applying
- Commit and push regularly
- Use .chezmoiignore to exclude sensitive files (like .bash_history)
- Use templates for machine-specific configurations

## License

MIT
