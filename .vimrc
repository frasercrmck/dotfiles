"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Preamble                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible

" Needed for Vundle, will be turned on after Vundle inits
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Vundle Configuration                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" other bundles:
Bundle 'scrooloose/nerdtree'
Bundle 'Valloric/YouCompleteMe'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'coderifous/textobj-word-column.vim'
Bundle 'rking/ag.vim'

Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

" Colour schemes:
Bundle 'sickill/vim-monokai'
Bundle 'jnurmine/Zenburn'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     Turn On Filetype Plugins                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable detection, plugins and indenting in one step
" This needs to come AFTER the Bundle commands!
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         General Settings                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256

" LOOK AND FEEL
colorscheme zenburn            " select zenburn

set gfn=Consolas:h10

set laststatus=2               " the status line is always shown
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P

" highlight the 81st column of wide lines
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

syntax on

" set tags=./tags;/

" EDITOR SETTINGS
set sessionoptions=blank,buffers,sesdir,folds,help,options,tabpages,winsize

set nocompatible

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
highlight MatchParen cterm=none ctermbg=green ctermfg=blue

set grepprg=grep\ -nRHi\ $*    " grep command defaults

set backupdir=~/.vim/backup    " move backups out of .git folders

let g:clipbrdDefaultReg = '+'  " set clipboard register to '+'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Mappings                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Exist insert mode by typing jk
inoremap jk <Esc>

" Swap ; and : since we used : more often than ;
nnoremap ; :
nnoremap : ;

" Swap ` and ' to jump to markers
nnoremap ' `
nnoremap ` '

" Search for word under cursor, but don't jump to it
nnoremap <Leader>* *''

" Bash-style Ctrl-A/E mappings to jump to Home/End in Insert mode.
inoremap <C-a> <Home>
inoremap <C-e> <End>

" Make Y behave like C and D
nnoremap Y y$

" QuickFix result navigating
nnoremap <silent> ]q :cnext<CR>zz
nnoremap <silent> [q :cprev<CR>zz
nnoremap <silent> ]Q :clast<CR>zz
nnoremap <silent> [Q :cfirst<CR>zz

" This makes j and k work on 'screen lines' instead of on 'file lines'; now,
" when we have a long line that wraps to multiple lines, j and k behave as we
" expect them to.
nnoremap <silent> k gk
nnoremap <silent> j gj

" Create blank newlines above or below us and stay in normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

" Space toggles folds
nnoremap <space> za

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

" Edit vimrc \gv
nnoremap <silent> <Leader>gv :tabnew<CR>:e ~/.vimrc<CR>

" Switch to the directory of the open buffer
nnoremap <leader>cd :cd %:p:h<CR>

" Escape search highlighing with \\
nnoremap <silent> <Leader><Leader> :noh<Return><Esc>

" Unmap certain operations I accidentally hit
nnoremap <F1> <nop>
nnoremap <Q> <nop>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Taglist Configuration                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let Tlist_Use_Right_Window = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_SingleClick = 1
let Tlist_Inc_Winwidth = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       Easy Motion Configuration                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set leader back to <Leader>
let g:EasyMotion_leader_key = '<Leader>'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     You Complete Me Configuration                       "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ycm_min_num_of_chars_for_completion = 99

let g:ycm_confirm_extra_conf = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                      Clang Format Configuration                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map  <C-K> :pyf ~/.vim/clang-format.py<CR>
imap <C-K> <ESC>:pyf ~/.vim/clang-format.py<CR>i

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Auto Commands                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Search for the word under the cursor
command! -nargs=1 Agc :Ag! <cword> <f-args>

command! -range UnstringifyKernel :silent!<line1>,<line2>s!\([^\\]\|^\)\(\\n\)\?"!\1!ge|<line1>,<line2>s!\\\("\|\\\)!\1!ge

" Automatically cd into the directory that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

autocmd FocusLost * :set norelativenumber
autocmd FocusGained * :set relativenumber

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

