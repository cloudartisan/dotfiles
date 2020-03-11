#!/bin/sh


mkdir -p ${HOME}/.vim
curl -Lso - https://github.com/cloudartisan/dotvim/tarball/master \
    | tar --strip-components 1 -C $HOME/.vim -zvxf -

ln -sf ${HOME}/.vim/vimrc ${HOME}/.vimrc
ln -sf ${HOME}/.vim/vimrc ${HOME}/.gvimrc

cd ${HOME}/.vim
git init
git submodule init
git submodule add https://github.com/VundleVim/Vundle.vim.git bundle/Vundle.vim/
git submodule update

alias vim=/usr/local/bin/vim
alias vi=/usr/local/bin/vim

# Remove unused plugins and install any missing plugins
vim "+PluginClean!" "+qall"
vim "+PluginInstall" "+qall"

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
if [[ -d ${HOME}/.vim/bundle/YouCompleteMe ]]
then
  if [[ ! -e ${HOME}/.vim/bundle/YouCompleteMe/third_party/ycmd/ycm_core.so ]]
  then
    ${HOME}/.vim/bundle/YouCompleteMe/install.py --clang-completer --java-completer
  fi
fi

vim "+GoInstallBinaries" "+qall"
