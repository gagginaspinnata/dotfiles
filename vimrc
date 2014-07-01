set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" This is the Vundle package, which can be found on GitHub.
" For GitHub repos, you specify plugins using the
" 'user/repository' format
Plugin 'gmarik/vundle'

" We could also add repositories with a ".git" extension
Plugin 'scrooloose/nerdtree.git'

" To get plugins from Vim Scripts, you can reference the plugin
" by name as it appears on the site
Plugin 'Buffergator'

" Syntax hihgler
Plugin 'scrooloose/syntastic'

" Autocompletion plugin
" Plugin 'Shougo/neocomplcache.vim'

" Pluginper gli snippet
Plugin 'msanders/snipmate.vim'

" Plugin per la gestione delle parentesi, per maggiori informazioni: https://github.com/jiangmiao/auto-pairs
 Plugin 'jiangmiao/auto-pairs'


" Now we can turn our filetype functionality back on
filetype plugin indent on

" Enable syntax high.
syntax on

" Set the default charset
set encoding=utf-8 nobomb

" Enable line number
set number

" Highligth cursor line
set cursorline

" Set tab as 2 white space
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab


" Enable mouse in all mode
set mouse=a

" Show the cursor position
set ruler

" Show the filename inside the titlebar
set title

" Show command as it's being typed
" set showcmd

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction


" starts nerdtree when vim is opened
" autocmd vimenter * NERDTree

" Map CTRL+n to toggle nerdtree
map <C-n> :NERDTreeToggle<CR>

"  close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

filetype plugin on


" More Common Settings.
 set scrolloff=3
 set autoindent
 set showmode
 set hidden
 set visualbell
