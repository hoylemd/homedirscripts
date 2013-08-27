"========================================================'
" $Author: hoylemd <Michael D. Hoyle>
" ======================================================='
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""'
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""'
set history=700 " Sets line history
set autoread    " Sets to autoread when the file is changed externally

let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>
if has("gui_running") " CTRL-S save support in GVIM
    map <silent> <c-s> :if expand("%") == ""<CR>:browse confirm w<CR>:else<CR>:confirm w<CR>:endif<CR>
    imap <c-s> <c-o><c-s>
endif

""""""""""""""""""""""""""""""""""""'
" => VIM User Interface
""""""""""""""""""""""""""""""""""""'
set so=7
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
set scrolloff=3     " Minimum number of lines to keep above and below the cursor

" What to show when you do :set list.
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

""""""""""""""""""""""""""""""""""""'
" => Colours and Fonts
""""""""""""""""""""""""""""""""""""'
syntax enable "Enable syntax hl

" set gfn=Monospace\ 10
" set shell=/bin/bash
" set gfn=Monaco:h10:cANSI
set gfn=Consolas:h11:cANSI

set background=dark
colorscheme koehler
if has("gui_running")
    set guioptions-=T
    set t_Co=256
    set nu          " Line numbers
else
    set nonu        " No line numbers
endif

autocmd! bufwritepost vimrc source ~/.vimrc

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
set shiftwidth=4
set tabstop=4
set softtabstop=4
"set smarttab          " User tabs at the start of a lines, spaces otherwise

"set autoindent        " Automatic indenting on new line
set smartindent       " Smart indenting, based on typed code
set wrap              "Wrap lines

set lbr
set tw=500

""""""""""""""""""""""""""""""""""""'
" => Mappings
""""""""""""""""""""""""""""""""""""'
"Move a line or visual selection up or down with <ALT-k> or <ALT-j>
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

nmap <M-down> <M-j>
nmap <M-up> <M-k>
vmap <M-down> <M-j>
vmap <M-down> <M-k>

" space bar un-highlights search
:noremap <silent> <Space> :silent noh<Bar>echo<CR>

autocmd BufEnter ?akefile* set noet ts=8 sw=8 nocindent
"Delete trailing white space
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
"Call when ever a buffer with file <*> is written
 autocmd BufWrite * :call DeleteTrailingWS()

"set the vim shell
:set shell=/bin/bash\ -l

" define some source control commands
" diff current file
:com! D :!d %
" add/stage current file
:com! A :!a %
" add git status
:com! S :!s
" add git log
:com! L :!log -f
" add git graph
:com! G :!graph -f
" add commit
:com! C :!ci


" Source the local vim changes
if filereadable("~/.vim_local")
	source ~/.vim_local
endif
