# CLAUDE.md - Development Guide

## Scope

This repository manages a PERSONAL-ONLY setup (macOS, zsh). All work/
Salesforce configuration was removed in June 2026, and the history was
later rewritten to purge those files entirely. They are NOT recoverable
from git history - do not go looking for them there.

## Commands

### Primary Installation Method
- `bootstrap-chezmoi.sh --apply` - Complete system setup (recommended)

### Manual Installation & Setup (Utilities)

Source files live in `bin/` with chezmoi's `executable_` prefix and are
deployed to `~/bin` (on the PATH via `.zshrc`), so invoke them by their
deployed names, not by their source paths.

- `install_vim` - Install vim configuration
- `install_tmux` - Install tmux configuration
- `install_brew` - Install Homebrew packages

### Maintenance
- `update_vim` - Update vim plugins
- `upgrade_brew` - Upgrade Homebrew packages
- `setup_hugo_completion` - Setup Hugo completion
- `sweep-secret-scanning [--dry-run]` - Re-enable GitHub secret scanning on
  public repos (personal machines only)

### chezmoi Workflow (Recommended)
- `chezmoi init --apply https://github.com/cloudartisan/dotfiles.git` - Initial setup
- `chezmoi update` - Pull latest changes and apply
- `chezmoi edit ~/.file` - Edit a managed dotfile
- `chezmoi add ~/.file` - Add a new file to management
- `chezmoi apply` - Apply changes to home directory
- `chezmoi diff` - Preview changes before applying
- `chezmoi git -- commit -m "message"` - Run git in the source directory

`chezmoi cd` takes an optional *path* and launches an interactive shell; it
does not run a command. Use `chezmoi git` for one-off git commands, and put
`--` before any git flags so chezmoi does not try to parse them itself.

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
chezmoi git add .
chezmoi git -- commit -m "Update zshrc"
chezmoi git push
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
chezmoi git add .
chezmoi git -- commit -m "Update zshrc"
chezmoi git push
```

### Adding New Files
```bash
# Add a new dotfile to management
chezmoi add ~/.new_config_file

# Commit and push
chezmoi git add .
chezmoi git -- commit -m "Add new config file"
chezmoi git push
```

### Testing Changes
```bash
# Preview what would change before applying
chezmoi diff

# Apply changes to test locally
chezmoi apply

# If satisfied, commit and push
chezmoi git add .
chezmoi git -- commit -m "Description"
chezmoi git push
```

On a machine where the source directory is a normal checkout (for example
`~/Projects/dotfiles`, as set by `bootstrap-chezmoi.sh`), plain git from
inside that checkout is equivalent and often simpler.

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

### Secret Protection

This repository is PUBLIC and the chezmoi workflow routinely copies files out
of `$HOME`, so two layers guard against committing secrets:

- **GitHub secret scanning and push protection** (server-side) reject a push
  containing a recognised credential. They cannot be bypassed locally.
- **pre-commit hooks** (`.pre-commit-config.yaml`) run gitleaks plus private-key
  and large-file checks against staged content. Installed per checkout by
  `.chezmoiscripts/run_once_setup-pre-commit.sh.tmpl`; run `pre-commit install`
  by hand if a checkout is missing them.

That script also runs `pre-commit init-templatedir ~/.git-template`, which
`init.templateDir` in `dot_gitconfig` points at, so every repository cloned or
created from then on gets the hook automatically. The generated hook passes
`--skip-on-missing-config`, so it is inert where there is no
`.pre-commit-config.yaml`. It applies to clone/init only - checkouts that
already existed still need `pre-commit install` once each.

`.chezmoiignore` only excludes known sensitive *paths*; the hooks are what
inspect file *contents*. Never bypass them with `--no-verify` to land a secret.

A personal GitHub account cannot default scanning on for new repositories, so
`bin/sweep-secret-scanning` re-enables it weekly via a launch agent. Both the
agent and the script are personal-machine only, and the script additionally
refuses to act unless the authenticated `gh` account matches `github_login`
in `.chezmoidata/personal.yaml` - work repositories are never touched.

**Repos using husky:** husky sets `core.hooksPath`, so git ignores
`.git/hooks` entirely and `pre-commit install` has no effect. Bridge it by
calling `pre-commit run` from `.husky/pre-commit` instead. See `docs/`.

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
  - `direnv.zsh`, `tmux.zsh`, `git.zsh`, `vim.zsh`, `ssh.zsh`,
    `gpg.zsh`, `go.zsh`, `node.zsh`, `python.zsh` - Tool-specific config
    (`node.zsh` puts Volta's shims ahead of Homebrew for per-project Node)
  - `keys.zsh` - Loads API keys from `~/.keys/*.sh` (never committed), and
    provides `keys_add` for writing them safely
- **dot_zshenv** - Read by EVERY zsh invocation, including non-interactive
  scp/sftp sessions. Must stay silent and fast: stray output on stdout or
  stderr breaks scp/sftp, which parse the stream directly. Holds a deliberate
  allow-list of the few keys needed outside interactive shells (currently the
  Supabase token). Everything else belongs in `dot_zshrc`.
- **dot_zlogout** - Deactivates virtualenvs on exit
- **~/.zsh_local** - Machine-local config, sourced if present, never committed
- Prompt: starship; autosuggestions and syntax highlighting via Homebrew

### Key Files
- **bootstrap-chezmoi.sh** - Sets up new machine with chezmoi (primary method)
- **.chezmoi.toml.tmpl** - Config template; prompts once for the personal flag
  and pins `sourceDir` so a non-default checkout survives re-running `init`
- **.chezmoidata/personal.yaml** - Default for `.personal`, plus `github_login`
- **.chezmoidata/packages.yaml** - Linux package lists per package manager
- **.chezmoiscripts/run_once_install-packages.sh.tmpl** - Homebrew packages and cursor-agent installation
- **.chezmoiscripts/run_once_install-ai-cli-tools.sh.tmpl** - Codex and Gemini CLI installation
- **.chezmoiscripts/run_once_install-claude-code.sh.tmpl** - Claude Code CLI installation
- **.chezmoiscripts/run_once_setup-vim.sh.tmpl** - Vim setup
- **.chezmoiscripts/run_once_setup-tmux-plugins.sh.tmpl** - TPM and tmux plugin install
- **.chezmoiscripts/run_once_configure-shell.sh.tmpl** - zsh as login shell, iTerm2 shell integration
- **.chezmoiscripts/run_once_configure-iterm2.sh.tmpl** - iTerm2 preferences from iCloud Drive (macOS only)
- **.chezmoiscripts/run_once_configure-gpg.sh.tmpl** - GPG agent configuration
- **.chezmoiscripts/run_once_configure-macos.sh.tmpl** - macOS settings
- **.chezmoiscripts/run_once_setup-volta.sh.tmpl** - Volta setup and default node@lts
- **.chezmoiscripts/run_once_setup-pre-commit.sh.tmpl** - Installs the pre-commit hooks into the source checkout and seeds `~/.git-template`
- **.chezmoiscripts/run_onchange_load-secret-scanning-sweep.sh.tmpl** - Loads the weekly sweep launch agent (personal machines only)
- **.pre-commit-config.yaml** - Secret-scanning hooks (gitleaks, private keys, large files)
- **bin/sweep-secret-scanning** - Re-enables GitHub secret scanning on public repos; guards on the authenticated account
- **Library/LaunchAgents/** - launchd agents (personal machines only, see .chezmoiignore)
- **Brewfile** - Homebrew packages definition
- **Brewfile.personal** - Personal-only packages, gated on `.personal`
- **dot_claude/CLAUDE.md** - The global Claude Code instructions file, deployed
  to `~/.claude/CLAUDE.md`. Not this file: `/CLAUDE.md` is repo-only and is
  excluded in `.chezmoiignore`, which otherwise ignores all of `~/.claude`.
- **docs/** - Repository documentation, excluded from deployment
- **bin/** - Individual utility scripts for manual use

Scripts that depend on the Brewfile (Volta, pre-commit, tmux plugins) rely on
filenames sorting after `run_once_install-packages`, and each also skips
harmlessly if its tool is not yet on the PATH. Keep that ordering in mind when
renaming or adding scripts.

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
