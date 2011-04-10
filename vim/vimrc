call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set hidden
set number
set vb t_vb=

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

" Default indentation handling.
"
" Leave tab characters unmolested, but display only 2 characters wide
set noexpandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

" Number of spaces that a pre-existing tab is equal to.
" For the amount of space used for a new tab use shiftwidth.
au BufRead,BufNewFile *py,*pyw,*.c,*.h set tabstop=8

" What to use for an indent.
" This will affect Ctrl-T and 'autoindent'.
" Python: 4 spaces
" Ruby: 2 spaces
" C: tabs (pre-existing files) or 4 spaces (new files)
" Makefile: no tab expansion
au BufRead,BufNewFile *.py,*.pyw set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw set tabstop=4
au BufRead,BufNewFile *.py,*.pyw set softtabstop=4
au BufRead,BufNewFile *.py,*.pyw set expandtab
au BufRead,BufNewFile *.rb set shiftwidth=2
au BufRead,BufNewFile *.rb set tabstop=2
au BufRead,BufNewFile *.rb set softtabstop=2
au BufRead,BufNewFile *.rb set expandtab
fu Select_c_style()
    if search('^\t', 'n', 150)
        set shiftwidth=8
        set noexpandtab
    el 
        set shiftwidth=4
        set expandtab
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

" For full syntax highlighting:
let python_highlight_all=1
syntax on

" Automatically indent based on file type
filetype indent on

" Folding based on indentation: ``set foldmethod=indent``

" Set the default file encoding to UTF-8: ``set encoding=utf-8``

" Puts a marker at the beginning of the file to differentiate between UTF and
" UCS encoding (WARNING: can trick shells into thinking a text file is actually
" a binary file when executing the text file): ``set bomb``
