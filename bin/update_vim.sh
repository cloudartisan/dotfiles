#!/bin/sh

# Remove unused plugins and install latest
vim "+PluginClean!" "+qall"
vim "+PluginInstall!" "+qall"

# Snapshot bash prompt settings for reuse
vim "+PromptlineSnapshot! ${HOME}/.bash_promptline_airline airline" "+qall"

# Snapshot tmux status settings for reuse
vim "+TmuxlineSnapshot! ${HOME}/.tmux_tmuxline.conf" "+qall"

# Compile YouCompleteMe if it's installed
if [[ -d $HOME/.vim/bundle/YouCompleteMe ]]; then
  $HOME/.vim/bundle/YouCompleteMe/install.py --clang-completer --java-completer
fi

vim "+GoInstallBinaries" "+qall"
