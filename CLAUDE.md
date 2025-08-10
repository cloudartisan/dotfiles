# CLAUDE.md - Development Guide

## Commands

### Primary Installation Method
- `bootstrap-chezmoi.sh --apply` - Complete system setup (recommended)

### Manual Installation & Setup (Utilities)
- `./bin/install_vim` - Install vim configuration
- `./bin/install_tmux` - Install tmux configuration  
- `./bin/install_brew` - Install Homebrew packages
- `./bin/install_cursor_agent` - Install Cursor AI agent CLI tool

### Maintenance
- `./bin/update_vim` - Update vim plugins
- `./bin/upgrade_brew` - Upgrade Homebrew packages
- `./bin/setup_hugo_completion` - Setup Hugo bash completion

### chezmoi Workflow (Recommended)
- `chezmoi init --apply https://github.com/cloudartisan/dotfiles.git` - Initial setup
- `chezmoi update` - Pull latest changes and apply
- `chezmoi edit ~/.file` - Edit a managed dotfile
- `chezmoi add ~/.file` - Add a new file to management
- `chezmoi apply` - Apply changes to home directory
- `chezmoi diff` - Preview changes before applying
- `chezmoi cd -- git commit -m "message" && git push` - Commit and push changes

## Style Guidelines
- **Shell Scripts**: Use POSIX-compatible syntax when possible
- **Comments**: Include descriptive comments for non-obvious operations
- **Variables**: Use lowercase with underscores (snake_case)
- **File Extensions**: .sh for shell scripts, .bash for Bash-specific scripts
- **Error Handling**: Check exit codes and fail early
- **Indentation**: 2 spaces
- **Line Length**: Keep under 80 characters when possible
- **Whitespace**: Unless necessary, blank lines must be empty of whitespace characters

## Development Workflow

### Making Changes to Dotfiles

#### Method 1: chezmoi (Recommended)
```bash
# Edit a file through chezmoi
chezmoi edit ~/.bash_profile

# Apply changes locally
chezmoi apply

# Commit and push changes
chezmoi cd -- git add . && git commit -m "Update bash profile" && git push
```

#### Method 2: Direct editing
```bash
# Edit file directly
vim ~/.bash_profile

# Add to chezmoi management
chezmoi add ~/.bash_profile

# Apply changes
chezmoi apply

# Commit and push
chezmoi cd -- git add . && git commit -m "Update bash profile" && git push
```

### Adding New Files
```bash
# Add a new dotfile to management
chezmoi add ~/.new_config_file

# Commit and push
chezmoi cd -- git add . && git commit -m "Add new config file" && git push
```

### Testing Changes
```bash
# Preview what would change before applying
chezmoi diff

# Apply changes to test locally
chezmoi apply

# If satisfied, commit and push
chezmoi cd -- git add . && git commit -m "Description" && git push
```

### Deploying to Other Machines
```bash
# Update all machines with latest changes
chezmoi update
```

## Git Workflow
- Keep commits small and focused on a single change
- Write descriptive commit messages
- Pull before pushing changes to avoid conflicts
- Do not include emojis in commit messages
- Do not mention Claude in commit messages
- Do not add/commit CLAUDE.md

## Architecture

### File Management Architecture

**chezmoi-based system:**
- **Source**: Files managed in `~/.local/share/chezmoi/` (git repository)
- **Deployment**: Files deployed to `~` via `chezmoi apply`
- **Automation**: Setup scripts in `.chezmoiscripts/` directory run once when applied
- **Templates**: `.tmpl` files support variables and conditionals for machine-specific configs
- **Updates**: `chezmoi update` pulls latest changes and applies them

### Key Files
- **bootstrap-chezmoi.sh** - Sets up new machine with chezmoi (primary method)
- **.chezmoiscripts/run_once_install-packages.sh.tmpl** - Automated package and cursor-agent installation
- **.chezmoiscripts/run_once_setup-vim.sh.tmpl** - Automated Vim setup
- **.chezmoiscripts/run_once_configure-git.sh.tmpl** - Automated Git configuration
- **.chezmoiscripts/run_once_configure-macos.sh.tmpl** - Automated macOS settings
- **.chezmoiscripts/run_once_configure-shell.sh.tmpl** - Automated shell configuration
- **Brewfile** - Homebrew packages definition  
- **bin/** - Individual utility scripts for manual use
