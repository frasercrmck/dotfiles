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

set foldmethod=marker

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

let g:clipbrdDefaultReg = '+'

" When I close a tab, remove the buffer
set nohidden

" Set off the other paren
highlight MatchParen ctermbg=4

" Needed for Syntax Highlighting and stuff
filetype on
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

" Open Url on this line with the browser \w
map <Leader>w :call Browser ()<CR>

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

" Stop cursor moving when joining lines
nnoremap J mzJ`z

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" Testing
set completeopt=longest,menuone,preview

inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"
inoremap <expr> <c-n> pumvisible() ? "\<lt>c-n>" : "\<lt>c-n>\<lt>c-r>=pumvisible() ? \"\\<lt>down>\" : \"\"\<lt>cr>"
inoremap <expr> <m-;> pumvisible() ? "\<lt>c-n>" : "\<lt>c-x>\<lt>c-o>\<lt>c-n>\<lt>c-p>\<lt>c-r>=pumvisible() ? \"\\<lt>down>\" : \"\"\<lt>cr>"

" Fix email paragraphs
nnoremap <leader>par :%s/^>$//<CR>

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

"{{{Clang Complete Configuration
"" Complete options (disable preview scratch window)
set completeopt=menu,menuone,longest
" Limit popup menu height
set pumheight=15
 
highlight Pmenu ctermbg=238 gui=bold

" SuperTab option for context aware completion
let g:SuperTabDefaultCompletionType = "context"

" Disable auto popup, use <Tab> to autocomplete
let g:clang_complete_auto = 0 
" Select first entry in popup menu but don't insert the code
let g:clang_auto_select = 1
" Show clang errors in the quickfix window
" let g:clang_complete_copen = 1
" Highlight errors and warnings
" let g:clang_complete_hl_errors = 1
" Update quicfix periodically
" let g:clang_periodic_quickfix = 1

let g:clang_use_library = 1
let g:clang_library_path = "/usr/lib"
"}}}

"{{{Easy Motion Configuration

" Set leader back to <Leader>
let g:EasyMotion_leader_key = '<Leader>'

"}}}

"{{{ Pathogen Configuration

execute pathogen#infect()

" Generate helptags for everything in 'runtimepath'
call pathogen#helptags()

"}}}

source ~/.vim/autotag.vim

filetype plugin indent on
syntax on
