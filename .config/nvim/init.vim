"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Preamble                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if !has('nvim')
  set nocompatible
endif

if has('nvim')
  let g:editor_root=expand("~/.config/nvim")
else
  let g:editor_root=expand("~/.vim")
endif

" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" "                        Vim-Plug Configuration                           "
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if empty(glob(g:editor_root.'/autoload/plug.vim'))
  execute 'silent !curl -fLo '.g:editor_root.'/autoload/plug.vim --create-dirs
           \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * source $MYVIMRC
endif

call plug#begin(g:editor_root."/bundle")

" Plugins
Plug 'rking/ag.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'frasercrmck/swizzle.vim'
Plug 'frasercrmck/formative.vim'
Plug 'Valloric/YouCompleteMe', {
      \   'do': './install.py --clang-completer --system-libclang',
      \   'for': [ 'c', 'cpp' ]
      \ }

" Colour schemes:
Plug 'whatyouhide/vim-gotham'

" Syntax files:
Plug 'frasercrmck/opencl.vim', { 'for': 'opencl' }

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         General Settings                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" LOOK AND FEEL
colorscheme gotham256          " select 256-colour gotham colourscheme

set gfn=Consolas:h10

set laststatus=2               " the status line is always shown
set statusline=%f%m%r%h%w\ [%l/%L,\ %v]\ [%p%%]\ %=[TYPE=%Y]\ [FMT=%{&ff}]\ %{\"[ENC=\".(&fenc==\"\"?&enc:&fenc).\"]\"}

syntax on

" EDITOR SETTINGS
set sessionoptions=blank,buffers,sesdir,folds,help,options,tabpages,winsize

set showcmd                    " show typed command in status bar

set foldmethod=syntax          " fold source code based on synax
set foldlevelstart=99          " open all folds by default
set foldnestmax=5              " limit amount of folds to 5-deep

set autoindent                 " auto-indentation

set expandtab                  " treat tabs as spaces
set smarttab                   " treat tabs as spaces

set backspace=indent,eol,start " allows backspacing over everything in insert mode
set shiftwidth=2               " set tabs to 2 spaces
set softtabstop=2              " set tabs to 2 spaces

" first  <Tab>  tries to complete longest match.
" second <Tab> lists possible matches
" third  <Tab> completes the next full match
set wildmode=longest,list,full
set wildmenu                   " completion with menu
set wildignore=*.o,*.obj.*.exe " ignore binaries when listing files

set mouse=a                    " enable mouse support

set nohidden                   " when I close a tab, remove the buffer

set number                     " show line numbers
set relativenumber             " show line numbers as relative offsets

set smartcase                  " match case if pattern contains upper case chars
set ignorecase                 " case-insensitive matches

set hlsearch                   " highlight all search matches
set incsearch                  " incremental search

set cursorline                 " highlight the current line

set completeopt=menu,menuone   " insert-mode completion menu

" Highlight matching parenthesis
highlight MatchParen cterm=none ctermbg=darkmagenta ctermfg=blue

set grepprg=grep\ -nRHi\ $*    " grep command defaults

execute 'set backupdir='.g:editor_root.'/backup'

set clipboard=unnamed          " Use the '*' register
let g:clipbrdDefaultReg = '*'  " set clipboard register to '*'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Mappings                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Exit insert mode by typing jk
inoremap jk <Esc>

" Swap ` and ' to jump to markers
nnoremap ' `
nnoremap ` '

" Set <Leader> to space key
let mapleader = " "

" Search for word under cursor, but don't jump to it
nnoremap <Leader>* :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" Bash-style Ctrl-A/E mappings to jump to Home/End in Insert mode.
inoremap <C-a> <Home>
inoremap <C-e> <End>

" Make Y behave like C and D
nnoremap Y y$

" This makes j and k work on 'screen lines' instead of on 'file lines'; now,
" when we have a long line that wraps to multiple lines, j and k behave as we
" expect them to.
nnoremap <expr> k (v:count ? 'k' : 'gk')
nnoremap <expr> j (v:count ? 'j' : 'gj')

" Stop the cursor moving when joining lines
nnoremap J mzJ`z

" Keep search matches in the middle of the window.
" zz centers the screen on the cursor, zv unfolds any fold if the cursor
" suddenly appears inside a fold
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap n nzzzv
nnoremap N Nzzzv

" Using '<' and '>' in visual mode to shift code by a tab-width left/right by
" default exits visual mode. With this mapping we remain in visual mode after
" such an operation.
vnoremap < <gv
vnoremap > >gv

" Highlight the last-inserted text
nmap gV `[v`]

" Edit vimrc or init.vim: <Leader>ev
function! OpenMYVIMRC()
  if !empty(expand('%:t'))
    :tabnew
  endif
  :e $MYVIMRC
endfunction

nnoremap <silent> <Leader>ev :<C-U>call OpenMYVIMRC()<CR>

" Escape search highlighing with <Leader><Leader>
nnoremap <silent> <Leader><Leader> :noh<Return><Esc>

" Unmap certain operations I accidentally hit...
" Help pages
nnoremap <F1> <nop>
" Execute mode
nnoremap Q <nop>
nnoremap gQ <nop>
" Man pages
nnoremap K <nop>

nnoremap <silent> gc :cclose<CR>
nnoremap <silent> gl :lclose<CR>

nnoremap <silent> <leader>y "+y
nnoremap <silent> <leader>p "+p
nnoremap <silent> <leader>P "+P
vnoremap <silent> <leader>y "+y
vnoremap <silent> <leader>p "+p
vnoremap <silent> <leader>P "+P

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              GUI Options                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("gui_running")
  " No menu or toolbar
  set guioptions-=m
  set guioptions-=T

  " No scrollbars
  set guioptions-=L
  set guioptions-=l
  set guioptions-=R
  set guioptions-=r
  set guioptions-=b

  " No tab pages
  set guioptions-=e

  " Nice copy and paste
  set guioptions+=p

  " Don't bother me with pop ups
  set guioptions+=c
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     You Complete Me Configuration                       "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ycm_confirm_extra_conf = 0
let g:ycm_min_num_of_chars_for_completion = 99

" Perform the 'most sensible' GoTo operation on the word under the cursor
nnoremap <silent> gf :<C-U>YcmCompleter GoTo<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       Formative Configuration                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:fmtv_clang_format_py = g:editor_root.'/clang-format.py'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Custom Commands                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Search for the word under the cursor
command! -nargs=1 -complete=file Agc :Ag! <cword> <q-args>

" Convert a code block into a string literal
function! MakeStringLiteral()
  " Escape existing escape characters
  execute 's/\\/\\\\/ge'
  " Escape quotes
  execute 's/"/\\"/ge'
  " Prepend quote
  execute 's/^/"/ge'
  " Add end carriage return & quote
  execute 's/$/\\n"/ge'
  noh
endfunction

" Unconvert a code block from a string literal
function! UnMakeStringLiteral()
  " Undo end carriage return & quote
  execute 's/\\n"[^"]*$//ge'
  " Remove beginning quote
  execute 's/^\s*"//ge'
  " Unescape quotes
  execute 's/\\"/"/ge'
  " Unescape existing escape characters
  execute 's/\\\\/\\/ge'
  noh
endfunction

" This overrides tpope's mappings from vim-unimpaired
map <silent> ]y :call MakeStringLiteral()<CR>
map <silent> [y :call UnMakeStringLiteral()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Auto Commands                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Automatically cd into the directory that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Automatically set the fold method to 'marker' for vim files
autocmd FileType vim set foldmethod=marker
" Automatically set the fold method to 'indent' for cmake files
autocmd FileType cmake set foldmethod=indent

" Go to the last cursor location when a file is opened, unless this is a
" git commit (in which case it's annoying)
au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") && &filetype != "gitcommit" |
        \ execute("normal `\"") |
    \ endif
