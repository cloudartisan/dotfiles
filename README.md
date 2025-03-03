# Cloudartisan Dotfiles

A collection of configuration files and utility scripts for setting up a developer environment.

## Features

- Bash configuration with modular approach
- Tmux setup with useful key bindings and plugins
- Vim configuration with powerful plugins
- Git workflow configuration and utilities
- Cloud development tools configuration
- Homebrew package installation via Brewfile

## Installation

### Quick Install (everything)

```bash
curl -Lso - https://github.com/cloudartisan/dotfiles/tarball/master | \
tar --strip-components 1 --exclude LICENSE --exclude README.md \
    -C $HOME -zvxf -

# Then run the bootstrap script
cd ~/bin
./bootstrap.sh
```

### Selective Installation

You can also selectively install components:

```bash
# Just install dotfiles
./bin/install_dotfiles

# Just install Homebrew packages
./bin/install_brew

# Just install Vim configuration
./bin/install_vim

# Just install Tmux configuration
./bin/install_tmux
```

### Upgrading Homebrew Packages

To upgrade all Homebrew packages defined in the Brewfile:

```bash
./bin/upgrade_brew
```

## Customization

The Brewfile contains all package definitions and can be customized to add or remove packages. After editing, run `install_brew` to apply changes.

## Structure

- `.bash_*` - Modular bash configuration files
- `.vim*` - Vim configuration
- `.tmux*` - Tmux configuration
- `bin/` - Utility scripts and installers
- `Brewfile` - Homebrew package definitions