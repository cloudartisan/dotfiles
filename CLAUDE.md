# CLAUDE.md - Development Guide

## Commands
- `./bin/bootstrap` - Runs the full setup process
- `./bin/install_dotfiles` - Install dotfiles configuration
- `./bin/install_vim` - Install vim configuration
- `./bin/install_tmux` - Install tmux configuration
- `./bin/install_brew` - Install Homebrew packages
- `./bin/update_vim` - Update vim plugins
- `./bin/upgrade_brew` - Upgrade Homebrew packages
- `./bin/setup_hugo_completion` - Setup Hugo bash completion

## Style Guidelines
- **Shell Scripts**: Use POSIX-compatible syntax when possible
- **Comments**: Include descriptive comments for non-obvious operations
- **Variables**: Use lowercase with underscores (snake_case)
- **File Extensions**: .sh for shell scripts, .bash for Bash-specific scripts
- **Error Handling**: Check exit codes and fail early
- **Indentation**: 2 spaces
- **Line Length**: Keep under 80 characters when possible
- **Whitespace**: Unless necessary, blank lines must be empty of whitespace characters

## Git Workflow
- Keep commits small and focused on a single change
- Write descriptive commit messages
- Pull before pushing changes to avoid conflicts
- Do not include emojis in commit messages
- Do not mention Claude in commit messages
- Do not add/commit CLAUDE.md
