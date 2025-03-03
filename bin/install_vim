#!/bin/sh

if type brew &>/dev/null; then
  HOMEBREW_PREFIX=$(brew --prefix)
  brew reinstall vim
  alias vi=${HOMEBREW_PREFIX}/bin/vi
  alias vim=${HOMEBREW_PREFIX}/bin/vim
fi

mkdir -p ${HOME}/.vim

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

curl -Lso - https://github.com/cloudartisan/dotvim/tarball/master \
    | tar --strip-components 1 -C $HOME/.vim -zvxf -

ln -sf ${HOME}/.vim/vimrc ${HOME}/.vimrc
ln -sf ${HOME}/.vim/vimrc ${HOME}/.gvimrc

cd ${HOME}/.vim
git init
git submodule init
git submodule update

# Remove unused plugins and install any missing plugins
vim "+PlugInstall" "+qall"

# Snapshot bash prompt settings for reuse if we haven't already
if [[ ! -f ${HOME}/.bash_promptline_airline ]]
then
  vim "+PromptlineSnapshot ${HOME}/.bash_promptline_airline airline" "+qall"
fi

# Snapshot tmux status settings for reuse if we haven't already
if [[ ! -f ${HOME}/.tmux_tmuxline.conf ]]
then
  vim "+TmuxlineSnapshot ${HOME}/.tmux_tmuxline.conf" "+qall"
fi

# Compile YouCompleteMe if it's installed but not yet compiled
if [[ -d ${HOME}/.vim/plugged/YouCompleteMe ]]
then
  if [[ ! -e ${HOME}/.vim/plugged/YouCompleteMe/third_party/ycmd/ycm_core.so ]]
  then
    ${HOME}/.vim/plugged/YouCompleteMe/install.py --clang-completer --java-completer
  fi
fi

vim "+GoInstallBinaries" "+qall"
