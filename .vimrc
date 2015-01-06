" ========================================================'
" $Author: hoylemd <Michael D. Hoyle>'
" ========================================================'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""'
" => Vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""'
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Bundle 'mileszs/ack.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-fugitive'
Plugin 'nono/vim-handlebars'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Raimondi/delimitMate'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'

" resource .vimrc and call :PluginInstall to install plugins

" This does what it says on the tin. It will check your file on open too, not just on save.
" You might not want this, so just leave it out if you don't.
let g:syntastic_check_on_open=1
Plugin 'marijnh/tern_for_vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""'
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""'
set history=700 " Sets line history
set autoread    " Sets to autoread when the file is changed externally

" set the leader to ,
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

""""""""""""""""""""""""""""""""""""'
" => VIM User Interface
""""""""""""""""""""""""""""""""""""'
set scrolloff=7     " Minimum number of lines to keep above and below the cursor
set wildmenu        " Auto complete menu
set ruler           " Display cursor position data in status line
set showcmd         " Show partial commands in status line
set cmdheight=2
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set hidden          " Allow changing the buffer w/o saving
set diffopt+=iwhite " Diff option: ignore whitespace
set laststatus=2

set hlsearch
set incsearch
set nolazyredraw    " Redraw during macros (enable for potential speed increase

set showmatch       " Brace matching
set mat=2           " Cursor blink in 1/10 sec

" What to show when you do :set list.
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set nu          " Line numbers

""""""""""""""""""""""""""""""""""""'
" => Colours and Fonts
""""""""""""""""""""""""""""""""""""'

set t_Co=256
syntax on
set background=dark
colorscheme koehler

autocmd! bufwritepost imrc source ~/.vimrc

""""""""""""""""""""""""""""""""""""'
" => Encoding
""""""""""""""""""""""""""""""""""""'
set ffs=unix,dos,mac
set encoding=utf8
try
    lang en_US
catch
endtry

""""""""""""""""""""""""""""""""""""'
" => Backups
""""""""""""""""""""""""""""""""""""'
set nobackup
set nowb
set noswapfile

""""""""""""""""""""""""""""""""""""'
" => Tabbing and formatting
""""""""""""""""""""""""""""""""""""'
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
"set smarttab          " User tabs at the start of a lines, spaces otherwise

set autoindent        " Automatic indenting on new line

set lbr               "Line break on 500 characters
set tw=500

""""""""""""""""""""""""""""""""""""'
" => Mappings
""""""""""""""""""""""""""""""""""""'
" space bar un-highlights search
:noremap <silent> <Space> :silent noh<Bar>echo<CR>

" ctrl-c splits line
imap <C-c> <CR><Esc>O
""""""""""""""""""""""""""""""""""""'
" => Misc stuff
""""""""""""""""""""""""""""""""""""'

" Delete trailing white space
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc

" Delete trailing whitespace on save
 autocmd BufWrite * :call DeleteTrailingWS()

" set the vim shell
:set shell=/bin/bash\ -l

""""""""""""""""""""""""""""""""""""'
" => Changed for specific file types
""""""""""""""""""""""""""""""""""""'
" Makefiles
autocmd BufEnter ?akefile* set noet ts=8 sw=8 nocindent

""""""""""""""""""""""""""""""""""""'
" => Define some source control commands
""""""""""""""""""""""""""""""""""""'
" diff current file
:com! D :!d -f %
" add/stage current file
:com! A :!a %
" add git status
:com! S :!s -f
" add jslint
:com! L :!l -f %
" add jshint
:com! H :!jshint % > .output
" add git graph
:com! G :!graph -f
" add commit
:com! C :!ci

" function to add the vb function
function! VerticalSplitBuffer(buffer)
  execute "vert belowright sb" a:buffer
endfunction
command! -nargs=1 Vb call VerticalSplitBuffer(<f-args>)

" fix indents for makefiles
autocmd BufEnter ?akefile* set noet ts=8 sw=8 nocindent

" Source the local vim changes
if filereadable("~/.vim_local")
  source ~/.vim_local
endif

set runtimepath^=~/.vim/bundle/ctrlp.vim

set exrc
set secure

""""""""""""""""""""""""""""""""""""'
" => Python specific settings
""""""""""""""""""""""""""""""""""""'
"
" make vim stop beign silly with python
autocmd FileType python set softtabstop=4 | set tabstop=4
autocmd FileType python set shiftwidth=4 | set expandtab
autocmd FileType python set modelines=1
inoremap # X#

" Auto-flake8 python files on save
autocmd BufWritePost *.py call Flake8()

