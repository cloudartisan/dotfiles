# Migrating to Chezmoi

This document outlines the migration from traditional dotfiles to [chezmoi](https://www.chezmoi.io/).

## Why Chezmoi?

Compared to traditional dotfiles and symlinks (or directly copying files), chezmoi offers:

1. **Templating** - Different configurations for different machines
2. **State tracking** - Knows when local files differ from the source
3. **Idempotent operations** - Can safely run multiple times
4. **Secret management** - Better handling of sensitive information
5. **Cross-platform** - Works on any OS with minimal dependencies
6. **Shell-agnostic** - Easy to manage both bash and zsh configs

## How to Migrate

1. Install chezmoi:
   ```bash
   # On macOS
   brew install chezmoi
   
   # On Linux
   sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/bin
   ```

2. Bootstrap a new machine:
   ```bash
   # To review changes first
   ./bootstrap-chezmoi.sh
   
   # To apply immediately
   ./bootstrap-chezmoi.sh --apply
   ```

3. Or use the repo directly:
   ```bash
   chezmoi init https://github.com/cloudartisan/dotfiles.git
   chezmoi diff  # Review changes
   chezmoi apply # Apply changes
   ```

## Chezmoi Directory Structure

```
~/.local/share/chezmoi/          # Chezmoi source directory
├── .chezmoiignore               # Files to ignore when applying
├── .chezmoiscripts/             # Scripts to run during apply
│   └── run_once_setup.sh        # Runs once on first apply
├── dot_gitconfig                # Regular dotfile (.gitconfig)
├── dot_hgrc                     # Mercurial config (.hgrc)
├── dot_hgignore                 # Mercurial ignore patterns (.hgignore)
├── executable_dot_bash_profile  # Executable dotfile (.bash_profile)
├── dot_bash_aliases             # Regular dotfile (.bash_aliases)
├── dot_bash_functions           # Regular dotfile (.bash_functions)
├── dot_bash_git                 # Regular dotfile (.bash_git)
├── dot_bash_*                   # Other bash configuration files
├── dot_gemrc                    # Ruby gem config (.gemrc)
├── dot_irbrc                    # Ruby IRB config (.irbrc)
├── dot_ruby_version             # Ruby version (.ruby-version)
├── dot_fog                      # Fog configuration (.fog)
├── dot_tmux.conf                # Tmux configuration (.tmux.conf)
├── dot_tmux_tmuxline.conf       # Tmux statusline config (.tmux_tmuxline.conf)
├── dot_screenrc                 # Screen configuration (.screenrc)
├── dot_iterm2/                  # iTerm2 utilities and scripts (.iterm2/)
├── dot_tmuxinator/              # Tmux session configurations (.tmuxinator/)
├── private_dot_ssh/             # Private directory with restricted permissions (.ssh/)
└── bin/                         # Scripts directory
```

### Managed Configuration Files

The following files and directories are managed by Chezmoi:

#### Bash Configuration
All .bash_* files are managed by Chezmoi. The .bash_profile sources all other .bash_* files as follows:

```bash
. ${HOME}/.bash_aliases
. ${HOME}/.bash_functions
. ${HOME}/.bash_autocomplete
# ... and so on
```

#### Git and Version Control
- `.gitconfig` - Git configuration
- `.hgrc` - Mercurial configuration
- `.hgignore` - Mercurial ignore patterns

#### Terminal and Shell
- `.tmux.conf` and `.tmux_tmuxline.conf` - Tmux configuration
- `.screenrc` - Screen configuration
- `.iterm2/` - iTerm2 utilities

#### Programming Languages
- `.gemrc` and `.irbrc` - Ruby configuration
- `.ruby-version` - Ruby version specification
- `.fog` - Ruby Fog gem configuration for cloud services

#### SSH Configuration
- `.ssh/` - SSH keys and configuration (stored with private permissions)

When setting up a new workstation, all these files will be automatically added and managed by Chezmoi through the bootstrap script.

## Managing Different Machines

Chezmoi makes it easy to have different configurations for different machines using templates:

```
{{- if eq .chezmoi.hostname "work-laptop" -}}
# Work-specific configuration
{{- else -}}
# Personal configuration
{{- end -}}
```

## Common Commands

- `chezmoi add ~/.bashrc` - Add a file to be managed
- `chezmoi edit ~/.bashrc` - Edit the source file
- `chezmoi diff` - See pending changes
- `chezmoi apply` - Apply all changes
- `chezmoi update` - Pull and apply latest changes
