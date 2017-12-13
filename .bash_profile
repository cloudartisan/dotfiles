# Add local binaries to the PATH
export PATH=${HOME}/bin:${PATH}

# Colour in the CLI and when listing files/directories
export CLICOLOR=1
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

. ${HOME}/.bash_functions
. ${HOME}/.bash_autocomplete
. ${HOME}/.bash_ssh
. ${HOME}/.bash_git
. ${HOME}/.bash_vim
. ${HOME}/.bash_tmux
. ${HOME}/.bash_python
. ${HOME}/.bash_homebrew
. ${HOME}/.bash_rbenv
. ${HOME}/.bash_rvm
. ${HOME}/.bash_direnv
. ${HOME}/.bash_aws
. ${HOME}/.bash_gcloud

# Load any local stuff (i.e., not checked-in to the dotfiles repo)
[[ -f ${HOME}/.bash_local ]] && . ${HOME}/.bash_local

if [[ "${TERM_PROGRAM}" = "iTerm.app" ]] && [[ "${HOME}/.iterm2_shell_integration.bash" ]]
then
  . ${HOME}/.iterm2_shell_integration.bash
fi
