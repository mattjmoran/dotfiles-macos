" Indentation
set autoindent " New lines inherit the indentation of previous lines
set expandtab " Convert tabs to spaces
set shiftround " When shifting lines, round the indentation to the nearest multiple of shift width
set shiftwidth=4 " When shifting, indent using four spaces
set smarttab " Insert tab stop number of spaces when the tab key is pressed
set tabstop=4 " Indent using four spaces

" Search
set hlsearch " Enable search highlighting
set ignorecase " Ignore case when searching
set incsearch " Incremental search that shows partial matches
set smartcase " Automatically switch search to case-sensitive when search query contains an uppercase letters

" Text Rendering
set display+=lastline " Always try to show a paragraph’s last line
set encoding=utf-8 " Use an encoding that supports unicode
set linebreak " Avoid wrapping a line in the middle of a word
set scrolloff=1 " The number of screen lines to keep above and below the cursor
set sidescrolloff=5 " The number of screen columns to keep to the left and right of the cursor
syntax enable " Enable syntax highlighting
set wrap " Enable line wrapping

" User Interface
set laststatus=2 " Always display the status bar
set ruler " Always show cursor position
set wildmenu " Display command line’s tab complete options as a menu
set tabpagemax=50 " Maximum number of tab pages that can be opened from the command line
set cursorline " Highlight the line currently under cursor
set number " Show line numbers on the sidebar
set mouse=a " Enable mouse for scrolling and resizing
set title " Set the window’s title, reflecting the file currently being edited

" Miscellaneous
set formatoptions+=j " Delete comment characters when joining lines
set history=1000 " Increase the undo limit
set spell " Enable spellchecking
set showmatch " Shows matching brackets
set nocompatible

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/lightline.vim'
Plug 'frazrepo/vim-rainbow'

" Initialize plugin system
call plug#end()

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif
