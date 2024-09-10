#!/bin/sh

cd ${HOME}/.vim/
git submodule update --init --recursive

# Remove unused plugins and install latest
vim "+PlugInstall!" "+qall"

# Snapshot bash prompt settings for reuse
vim "+PromptlineSnapshot! ${HOME}/.bash_promptline_airline airline" "+qall"

# Snapshot tmux status settings for reuse
vim "+TmuxlineSnapshot! ${HOME}/.tmux_tmuxline.conf" "+qall"

# Compile YouCompleteMe if it's installed
if [[ -d $HOME/.vim/plugged/YouCompleteMe ]]; then
  $HOME/.vim/plugged/YouCompleteMe/install.py --clang-completer --java-completer
fi

vim "+GoInstallBinaries" "+qall"
