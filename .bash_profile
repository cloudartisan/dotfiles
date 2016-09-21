# Colour in the CLI and when listing files/directories
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

. ${HOME}/.bash_functions
. ${HOME}/.bash_autocomplete
. ${HOME}/.bash_git
. ${HOME}/.bash_ssh
. ${HOME}/.bash_homebrew
. ${HOME}/.bash_aws
. ${HOME}/.bash_tmux
. ${HOME}/.bash_python
. ${HOME}/.bash_rvm
. ${HOME}/.bash_vim

# Add local binaries to the PATH
export PATH=${HOME}/bin:${PATH}
