# CLAUDE.md - Development Guide

## Scope

This repository manages a PERSONAL-ONLY setup (macOS, zsh). All work/
Salesforce configuration was removed in June 2026 and is recoverable from
git history if ever needed.

## Commands

### Primary Installation Method
- `bootstrap-chezmoi.sh --apply` - Complete system setup (recommended)

### Manual Installation & Setup (Utilities)
- `./bin/install_vim` - Install vim configuration
- `./bin/install_tmux` - Install tmux configuration
- `./bin/install_brew` - Install Homebrew packages

### Maintenance
- `./bin/update_vim` - Update vim plugins
- `./bin/upgrade_brew` - Upgrade Homebrew packages
- `./bin/setup_hugo_completion` - Setup Hugo completion

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
- **File Extensions**: .sh for shell scripts, .zsh for zsh-specific files
- **Error Handling**: Check exit codes and fail early
- **Indentation**: 2 spaces
- **Line Length**: Keep under 80 characters when possible
- **Whitespace**: Unless necessary, blank lines must be empty of whitespace characters

## Development Workflow

### Making Changes to Dotfiles

#### Method 1: chezmoi (Recommended)
```bash
# Edit a file through chezmoi
chezmoi edit ~/.zshrc

# Apply changes locally
chezmoi apply

# Commit and push changes
chezmoi cd -- git add . && git commit -m "Update zshrc" && git push
```

#### Method 2: Direct editing
```bash
# Edit file directly
vim ~/.zshrc

# Add to chezmoi management
chezmoi add ~/.zshrc

# Apply changes
chezmoi apply

# Commit and push
chezmoi cd -- git add . && git commit -m "Update zshrc" && git push
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

#### New Machine Setup
```bash
# Initial setup on a brand new machine
chezmoi init --apply https://github.com/cloudartisan/dotfiles.git

# This will:
# - Clone the repository to ~/.local/share/chezmoi
# - Run setup scripts in .chezmoiscripts/
# - Deploy all dotfiles to your home directory
```

#### Updating Existing Machines
```bash
# Pull latest changes and apply to already configured machines
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

### Shell Configuration (zsh)

- **dot_zshrc** - Main shell config: PATH, history, completion, fragment sourcing
- **dot_zsh/** - Modular fragments deployed to `~/.zsh/`:
  - `homebrew.zsh` - Homebrew PATH and fpath (sourced first, before compinit)
  - `aliases.zsh`, `functions.zsh` - General aliases and functions
  - `direnv.zsh`, `tmux.zsh`, `git.zsh`, `gh.zsh`, `vim.zsh`, `ssh.zsh`,
    `gpg.zsh`, `go.zsh`, `python.zsh` - Tool-specific config
  - `keys.zsh` - Loads API keys from `~/.keys/*.sh` (never committed)
- **dot_zlogout** - Deactivates virtualenvs on exit
- **~/.zsh_local** - Machine-local config, sourced if present, never committed
- Prompt: starship; autosuggestions and syntax highlighting via Homebrew

### Key Files
- **bootstrap-chezmoi.sh** - Sets up new machine with chezmoi (primary method)
- **.chezmoiscripts/run_once_install-packages.sh.tmpl** - Homebrew packages and cursor-agent installation
- **.chezmoiscripts/run_once_install-ai-cli-tools.sh.tmpl** - Codex and Gemini CLI installation
- **.chezmoiscripts/run_once_install-claude-code.sh.tmpl** - Claude Code CLI installation
- **.chezmoiscripts/run_once_setup-vim.sh.tmpl** - Vim setup
- **.chezmoiscripts/run_once_configure-shell.sh.tmpl** - zsh as login shell, iTerm2 integration
- **.chezmoiscripts/run_once_configure-gpg.sh.tmpl** - GPG agent configuration
- **.chezmoiscripts/run_once_configure-macos.sh.tmpl** - macOS settings
- **Brewfile** - Homebrew packages definition
- **bin/** - Individual utility scripts for manual use

### AI CLI Tools

The following AI CLI tools are automatically installed during system setup:

**Claude Code CLI** (`claude`)
- Installed via: curl-based installer (official method)
- Script: `.chezmoiscripts/run_once_install-claude-code.sh.tmpl`

**OpenAI Codex CLI** (`codex`)
- Installed via: npm global (`@openai/codex`)
- Script: `.chezmoiscripts/run_once_install-ai-cli-tools.sh.tmpl`

**Google Gemini CLI** (`gemini`)
- Installed via: npm global (`@google/gemini-cli`)
- Script: `.chezmoiscripts/run_once_install-ai-cli-tools.sh.tmpl`

**Cursor Agent CLI** (`cursor-agent`)
- Installed via: curl-based installer
- Script: `.chezmoiscripts/run_once_install-packages.sh.tmpl`
