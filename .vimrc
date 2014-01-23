"{{{Auto Commands

" Automatically cd into the directory that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Restore cursor position to where it was before
augroup JumpCursorOnEdit
   au!
   autocmd BufReadPost *
            \ if expand("<afile>:p:h") !=? $TEMP |
            \   if line("'\"") > 1 && line("'\"") <= line("$") |
            \     let JumpCursorOnEdit_foo = line("'\"") |
            \     let b:doopenfold = 1 |
            \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
            \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
            \        let b:doopenfold = 2 |
            \     endif |
            \     exe JumpCursorOnEdit_foo |
            \   endif |
            \ endif
   " Need to postpone using "zv" until after reading the modelines.
   autocmd BufWinEnter *
            \ if exists("b:doopenfold") |
            \   exe "normal zv" |
            \   if(b:doopenfold > 1) |
            \       exe  "+".1 |
            \   endif |
            \   unlet b:doopenfold |
            \ endif
augroup END

"}}}

"{{{Misc Settings

set tags=./tags;/

set sessionoptions=blank,buffers,sesdir,folds,help,options,tabpages,winsize

set nocompatible

set showcmd

set foldmethod=syntax
set foldlevelstart=99
set foldnestmax=5

set autoindent

set expandtab
set smarttab

set shiftwidth=2
set softtabstop=2

set wildmenu
set wildmode=longest,list

set mouse=a

set backspace=2

set number
set relativenumber

set ignorecase

set smartcase

set incsearch

set wildignore=*.o,*.obj.*.exe

set hlsearch

set cursorline

let g:clipbrdDefaultReg = '+'

" When I close a tab, remove the buffer
set nohidden

set completeopt=menu,menuone,preview

" Set off the other paren
highlight MatchParen ctermbg=4

" Needed for Syntax Highlighting and stuff
" filetype on
filetype plugin on
syntax enable

set grepprg=grep\ -nRHi\ $*

command! -nargs=+ -complete=file Grep execute 'silent! grep! <args>' | redraw! | copen

cnoremap :grep :echo "hello"

" Move backups out of .git folders
set backupdir=~/.vim/backup

" }}}

"{{{Look and Feel
"
colors slate

set gfn=Consolas:h10

" Status line gnarliness
set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]

" Highlight the 81st column of wide lines
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" }}}

"{{{ Mappings

" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
inoremap jj <Esc>

nnoremap JJJJ <Nop>

" Swap ; and :  Convenient.
nnoremap ; :
nnoremap : ;

" Search for word under cursor, but don't jump
nnoremap <Leader>* *''

" Bash-style Ctrl-A/E mappings to jump to Home/End in Insert mode.
inoremap <C-a> <Home>
inoremap <C-e> <End>

" Escape search highlighing with \\
nnoremap <silent> <Leader><Leader> :noh<Return><Esc>

" New lines
map <C-j> O<Esc>
map <C-k> o<Esc>

" Make Y behave like C and D
nnoremap Y y$

" QuickFix result navigating
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [q :cprev<CR>
nnoremap <silent> ]Q :clast<CR>
nnoremap <silent> [Q :cfirst<CR>

" Edit vimrc \ev
nnoremap <silent> <Leader>ev :tabnew<CR>:e ~/.vimrc<CR>

" Edit gvimrc \gv
nnoremap <silent> <Leader>gv :tabnew<CR>:e ~/.gvimrc<CR>

" Up and down are more logical with g..
nnoremap <silent> k gk
nnoremap <silent> j gj
inoremap <silent> <Up> <Esc>gka
inoremap <silent> <Down> <Esc>gja

" Create Blank Newlines and stay in Normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

" Space will toggle folds!
nnoremap <space> za

" Highlight last inserted text
nmap gV `[v`]

" Stop cursor moving when joining lines
nnoremap J mzJ`z

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" Unmap certain operations I accidentally hit
nnoremap <F1> <nop>
nnoremap <Q> <nop>

"}}}

"{{{Taglist Configuration

let Tlist_Use_Right_Window = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_SingleClick = 1
let Tlist_Inc_Winwidth = 0

"}}}

"{{{Easy Motion Configuration

" Set leader back to <Leader>
let g:EasyMotion_leader_key = '<Leader>'

"}}}

"{{{ Vundle Configuration

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" other bundles:
Bundle 'scrooloose/nerdtree'
Bundle 'Valloric/YouCompleteMe'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'coderifous/textobj-word-column.vim'
Bundle 'rking/ag.vim'

"}}}

source ~/.vim/autotag.vim

filetype plugin indent on
syntax on
