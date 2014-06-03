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
Bundle 'rking/ag.vim'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-unimpaired'
Bundle 'Valloric/YouCompleteMe'

Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

" Colour schemes:
Bundle 'sickill/vim-monokai'
Bundle 'jnurmine/Zenburn'

" Syntax files:
Bundle 'frasercrmck/opencl.vim'

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

" This makes j and k work on 'screen lines' instead of on 'file lines'; now,
" when we have a long line that wraps to multiple lines, j and k behave as we
" expect them to.
nnoremap <silent> k gk
nnoremap <silent> j gj

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

" Escape search highlighing with \\
nnoremap <silent> <Leader><Leader> :noh<Return><Esc>

" Unmap certain operations I accidentally hit
nnoremap <F1> <nop>
nnoremap <Q> <nop>

nnoremap gc :cclose<CR>

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

  set guifont=Inconsolata\ for\ Powerline\ 10
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Taglist Configuration                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let Tlist_Use_Right_Window = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_SingleClick = 1
let Tlist_Inc_Winwidth = 0

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
command! -nargs=1 -complete=file Agc :Ag! <cword> <q-args>

command! -range UnstringifyKernel :silent!<line1>,<line2>s!\([^\\]\|^\)\(\\n\)\?"!\1!ge|<line1>,<line2>s!\\\("\|\\\)!\1!ge

" Twiddles a coordinate char from:
"   x -> y -> z -> w -> x -> ...
" or:
"   r -> g -> b -> a -> r -> ...
function! CoordSwizzle(argCount)
  " Get the char under the cursor
  let currentChar = getline(".")[col(".")-1]

  " Exit early if there is no coord under the cursor
  " Case-insensitive equality
  if currentChar != 'x' && currentChar != 'y' &&
        \currentChar != 'z' && currentChar != 'w' &&
        \currentChar != 'r' && currentChar != 'g' &&
        \currentChar != 'b' && currentChar != 'a'
    return
  endif

  if currentChar == 'r' || currentChar == 'g' ||
        \currentChar == 'b' || currentChar == 'a'
    let isColour = 1
  else
    let isColour = 0
  endif

  let replaceCount = a:argCount
  " Always swizzle at least one coord
  if replaceCount == 0
    let replaceCount = 1
  endif

  if isColour
    let startIndex = {'r': 0, 'g': 1, 'b': 2, 'a': 3}[tolower(currentChar)]
  else
    let startIndex = {'x': 0, 'y': 1, 'z': 2, 'w': 3}[tolower(currentChar)]
  endif

  let replaceIndex = (startIndex + replaceCount % 4) % 4

  if isColour
    let newChar = ['r', 'g', 'b', 'a'][replaceIndex]
  else
    let newChar = ['x', 'y', 'z', 'w'][replaceIndex]
  endif

  " Convert to uppercase if char under cursor is upper case
  if currentChar ==# toupper(currentChar)
    let newChar = toupper(newChar)
  endif

  " Finally, replace the char
  :exec ":normal r".newChar
endfunction

" Coordinate swizzle

noremap <silent> <Plug>CoordinateSwizzle :<C-U>call CoordSwizzle(v:count)<CR>
      \:call repeat#set("\<Plug>CoordinateSwizzle", v:count)<CR>

nmap <silent> cs <Plug>CoordinateSwizzle

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

