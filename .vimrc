set nocompatible

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Trust vim modelines in the files we edit
set modeline

" Disable search annoyances
set noincsearch
set nohlsearch

" Disable backups
set nobackup

" Get rid of all bells
set noerrorbells
set visualbell
set vb t_vb=

" Interface tweaks
set ruler            " show me a ruler
set noshowmode       " don't show me that I'm in INSERT mode
set scrolloff=8      " 8 lines of context around the cursor at all times
set foldclose=       " disable automatic fold closing
set showcmd          " show the vi command in the ruler
set showmatch        " show me matching parentheses, braces, etc
set matchpairs+=<:>  " include < > when matching
set ignorecase       " case-insensitive searching
set smartcase        " determine when I really want case-sensitive searching

" Enable syntax highlighting where possible
if has("syntax")
	syntax on
  let python_highlight_all=1
end

" 256 colours of sexiness
set background=dark
set t_Co=256
"colorscheme solarized
colorscheme desert256

" Use the system registry by default for the clipboard
set clipboard=unnamed

" Allow Ctrl+PgUp/PgDn in tmux
set t_kN=[6;*~
set t_kP=[5;*~

" Enable automatic wrap, use par to format paragraphs, remove superfluous
" lines
set formatoptions+=t
set textwidth=79
set formatprg=par\ -w79re

" Default indentation handling
set expandtab             " convert my tab characters to spaces
set shiftwidth=2          " shift by 2 spaces
set tabstop=2             " tabs are 2 spaces
set softtabstop=2
set backspace=indent,eol  " sensible backspacing
set autoindent
set nosmartindent

" Set title string and push it to xterm/screen window title
set titlestring=vim\ %<%F%(\ %)%m%h%w%=%l/%L-%P 
set titlelen=70
if &term == "screen" || &term == "tmux"
  set t_ts=k
  set t_fs=\
endif
if &term == "screen" || &term == "tmux" || &term == "xterm"
  set title
endif

" Support plugin documentation
if isdirectory("~/.vim/doc")
  helptags ~/.vim/doc
endif

" Allow filetype plugins (ft_plugin stuff)
filetype on
filetype plugin on
filetype plugin indent on

" What to use for an indent.
" This will affect Ctrl-T and 'autoindent'.
" Python: 4 spaces
" Ruby: 2 spaces
" ERB: 2 spaces
" YAML: 2 spaces
" Markdown: 2 spaces
" Clojure: 2 spaces
" C: tabs (pre-existing files) or 4 spaces (new files)
" Makefile: no tab expansion
au BufRead,BufNewFile *.py,*.pyw set sw=4 ts=4 sts=4 expandtab
au BufRead,BufNewFile *.rb,*.erb set sw=2 ts=2 sts=2 expandtab
au BufRead,BufNewFile *.yml set sw=2 ts=2 sts=2 expandtab
au BufRead,BufNewFile *.md set sw=2 ts=2 sts=2 expandtab
au BufRead,BufNewFile *.clj set sw=2 ts=2 sts=2 expandtab
fu Select_c_style()
    if search('^\t', 'n', 150)
        set sw=8 ts=8 noexpandtab
    el 
        set sw=4 ts=4 expandtab
    en
endf
au BufRead,BufNewFile *.c,*.h call Select_c_style()
au BufRead,BufNewFile Makefile* set noexpandtab

" Django template tags
au Filetype htmldjango inoremap <buffer> <c-t> {%<space><space>%}<left><left><left>

" Django template variables
au Filetype htmldjango inoremap <buffer> <c-v> {{<space><space>}}<left><left><left>

" Use the below highlight group when displaying bad whitespace
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/

" Flag trailing whitespace as bad.
" Python: yes
" Ruby: yes
" C: yes
au BufRead,BufNewFile *.py,*.pyw,*.rb,*.c,*.h match BadWhitespace /\s\+$/

" Wrap text after a certain number of characters
" Python: 79 
" Ruby: 79
" C: 79
au BufRead,BufNewFile *.py,*.pyw,*.rb,*.c,*.h set textwidth=79

" Highlight characters that go over the textwidth limit
:highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white
:match OverLength '\%79v.*'

" Turn off settings in 'formatoptions' relating to comment formatting.
" - c : do not automatically insert the comment leader when wrapping based on
"    'textwidth'
" - o : do not insert the comment leader when using 'o' or 'O' from command mode
" - r : do not insert the comment leader when hitting <Enter> in insert mode
" Python: not needed
" Ruby: not needed
" C: prevents insertion of '*' at the beginning of every line in a comment
au BufRead,BufNewFile *.c,*.h set formatoptions-=c formatoptions-=o formatoptions-=r

" Use UNIX (\n) line endings.
" Only used for new files so as to not force existing files to change their
" line endings.
" Python: yes
" Ruby: yes
" C: yes
au BufNewFile *.py,*.pyw,*.rb,*.c,*.h set fileformat=unix

" Folding based on indentation
set foldmethod=marker

" Set the default file encoding to UTF-8: ``set encoding=utf-8``

" Mappings to jump me to the beginning of functions
nnoremap [[ ?{<CR>w99[{
nnoremap ][ /}<CR>b99]}
nnoremap ]] j0[[%/{<CR>
nnoremap [] k$][%?}<CR>
