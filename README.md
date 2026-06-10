# Dotfiles

Personal dotfiles and configuration files managed with [chezmoi](https://www.chezmoi.io/).

This repository targets a personal macOS setup with a zsh shell. Linux is
supported for a subset of the configuration.

## Quick Start

To set up a new machine (one command does everything):

```bash
curl -fsLS https://raw.githubusercontent.com/cloudartisan/dotfiles/master/bootstrap-chezmoi.sh | bash -s -- --apply
```

If the repository is already checked out (e.g. `~/Projects/dotfiles`), run
the script from the checkout instead — it configures the checkout as the
chezmoi source directory, so there is only one copy to edit and commit:

```bash
cd ~/Projects/dotfiles
./bootstrap-chezmoi.sh           # preview mode; configures source, installs nothing else
chezmoi diff                     # review what would change
./bootstrap-chezmoi.sh --apply   # or: chezmoi apply
```

Either way, the bootstrap will:
- Install chezmoi (and Homebrew on macOS, adding it to the PATH for the
  duration of the script)
- Clone and apply the dotfiles
- Install all Brewfile packages
- Set zsh as the login shell with a starship prompt
- Set up Vim, Git, tmux, GPG, and macOS preferences
- Install AI CLI tools (Claude Code, Codex, Gemini) and Cursor Agent

## Features

- Modular zsh configuration (`.zshrc` sourcing fragments from `~/.zsh/`)
- starship prompt, zsh autosuggestions, and syntax highlighting
- Git configuration with personal identity
- Vim setup with plugins (from the dotvim repository)
- Tmux configuration with window auto-renaming for ssh
- Homebrew package management via Brewfile
- GPG with pinentry-mac

## Daily Usage

```bash
# Update this machine with the latest changes
chezmoi update

# Edit a dotfile
chezmoi edit ~/.zshrc

# Preview changes before applying
chezmoi diff

# Apply changes locally
chezmoi apply

# Commit and push changes
chezmoi cd -- git add . && git commit -m "Update config" && git push
```

Handy aliases (defined in `~/.zsh/aliases.zsh`): `cz`, `cza` (apply),
`czd` (diff), `cze` (edit), `czu` (update).

## Repository Structure

- `.chezmoiscripts/` - Automated setup scripts (run_once_*.sh.tmpl)
- `bin/` - Utility scripts for manual use
- `dot_zshrc`, `dot_zsh/` - Shell configuration
- `Brewfile` - Homebrew package definitions
- `bootstrap-chezmoi.sh` - Primary installation script
- Various dotfiles (`.gitconfig`, `.tmux.conf`, etc.)

### chezmoi File Types

- `run_once_*.sh.tmpl` - Scripts that run once during setup
- `*.tmpl` - Template files with variables/conditionals
- `private_*` - Files deployed with restricted permissions
- Regular files - Deployed as-is to the home directory

## Automated Setup Scripts

- **run_once_install-packages.sh.tmpl** - Installs Homebrew, all Brewfile packages, and Cursor Agent CLI
- **run_once_install-ai-cli-tools.sh.tmpl** - Installs Codex and Gemini CLIs via npm
- **run_once_install-claude-code.sh.tmpl** - Installs Claude Code CLI via the official installer
- **run_once_setup-vim.sh.tmpl** - Configures Vim with plugins from the dotvim repository
- **run_once_configure-shell.sh.tmpl** - Sets zsh as the login shell and installs iTerm2 shell integration
- **run_once_configure-gpg.sh.tmpl** - Sets .gnupg permissions and restarts gpg-agent
- **run_once_configure-macos.sh.tmpl** - Configures macOS preferences (only on macOS)
- **run_onchange_install-linux-packages.sh.tmpl** - Installs Linux packages (only on Linux)

Scripts run automatically during `chezmoi init --apply` or `chezmoi apply`.
The `run_once_` prefix ensures they only run once per machine.

## Available Commands

Utility scripts deployed to `~/bin`:

### Manual Installation & Setup
- `install_brew` - Install Homebrew and packages from Brewfile
- `install_vim` - Set up Vim with plugins and configuration
- `install_tmux` - Install and configure tmux

### Maintenance
- `upgrade_brew` - Update Homebrew and all packages
- `update_vim` - Update Vim plugins
- `setup_hugo_completion` - Set up Hugo completion

### Git Utilities
- `git-ignore` - Add files to .gitignore
- `git-author-rewrite.sh` - Rewrite commit author history
- `git-repull-ship.bash` - Git workflow helpers (repull/ship)

### System Utilities
- `ps-rss`, `ps-priv-dirty-rss` - Memory usage tools
- `gittarz` - Archive utilities
- `vidslurp` - Video processing tool

## How This Repository Works

**The GitHub repository is the authoritative source of truth.**

- **GitHub repository** - The master copy of the dotfiles
- **~/.local/share/chezmoi** - Local clone of the repository
- **Home directory (~)** - Where the deployed dotfiles live

### Editing Existing Dotfiles

```bash
# Edit through chezmoi (recommended)
chezmoi edit ~/.zshrc

# Apply changes to your home directory
chezmoi apply

# Commit and push
chezmoi cd -- git add . && git commit -m "Update zshrc" && git push
```

### Adding New Dotfiles

```bash
# Add a new config file
chezmoi add ~/.my_new_config

# Commit and push
chezmoi cd -- git add . && git commit -m "Add new config" && git push
```

### Machine-Local Configuration

Anything machine-specific that should stay out of the repository can go in
`~/.zsh_local`, which is sourced at the end of `.zshrc` if present. API keys
live in `~/.keys/*.sh` files (never committed) and are loaded by
`~/.zsh/keys.zsh`.

## License

See [LICENSE](LICENSE).
