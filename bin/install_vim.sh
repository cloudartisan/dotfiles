#!/bin/sh

vim "+PluginInstall" "+qall"
vim "+PromptlineSnapshot! ${HOME}/.bash_promptline_airline airline" "+qall"

# Compile YouCompleteMe if it's installed
if [[ -d $HOME/.vim/bundle/YouCompleteMe ]]; then
  $HOME/.vim/bundle/YouCompleteMe/install.py --clang-completer
fi

