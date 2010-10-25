" Disable backups
set nobackup

" Show the cursor position
set ruler

" Enable syntax highlighting
syntax on
set background=light

" Enable automatic wrap
set tw=78

" Enable automatic indentation
set autoindent

" Convert tabs characters to four spaces and make the group of spaces
" feel like a real tab character
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Do not expand tab characters in make files
autocmd FileType make set ts=4 noexpandtab
autocmd BufRead,BufNewFile (m|M)akefile set ts=4 noexpandtab

" Do not expand tab characters in calendar files
autocmd FileType calendar set ts=8 sw=8 sts=8 noexpandtab
autocmd BufRead,BufNewFile calendar set ts=8 sw=8 sts=8 noexpandtab

" Syntax highlighting for reminder files
autocmd BufRead,BufNewFile *.rem set filetype=remind
autocmd! Syntax remind source $HOME/.vim/syntax/remind.vim
