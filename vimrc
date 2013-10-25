" Make vim useful
set nocompatible

" Enable syntax high.
syntax on

" Set the default charset
set encoding=utf-8 nobomb

" Enable line number
set number

" Highligth cursor line
set cursorline

" Set tab as 2 white space
set tabstop=2

" Enable mouse in all mode
set mouse=a

" Show the cursor position
set ruler

" Show the filename inside the titlebar
set title

" Show command as it's being typed
set showcmd

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
