# Git helpers
source ~/bin/git-repull-ship.bash

# Load the global .gitignore file - only if not already set
if [ -f ~/.gitignore ] && ! git config --global --get core.excludesfile >/dev/null 2>&1
then
  git config --global core.excludesfile $HOME/.gitignore
fi

# Alias git to g (zsh completion follows the alias automatically)
alias g=git

# Set personal identity explicitly in a repo if ever needed
alias gitme="git config user.email david@cloudartisan.com; git config user.name cloudartisan"
