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
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin(g:editor_root."/bundle")

" Plugins
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'frasercrmck/swizzle.vim'
Plug 'rhysd/git-messenger.vim'
Plug 'bogado/file-line'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" Language server stuff
if has('nvim')
  Plug 'neovim/nvim-lspconfig' " Easy ready-made LSP configs
  Plug 'hrsh7th/cmp-nvim-lsp'  " For auto-completions
  Plug 'hrsh7th/nvim-cmp'      " For auto-completions
  Plug 'L3MON4D3/LuaSnip'      " For snippets (required by nvim-cmp)
endif

" Colour schemes:
Plug 'whatyouhide/vim-gotham'
Plug 'catppuccin/vim', { 'as': 'catppuccin_vim' }
Plug 'catppuccin/nvim', { 'as': 'catppuccin_nvim' }

" Syntax files:
Plug 'frasercrmck/opencl.vim', { 'for': 'opencl' }

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         General Settings                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" LOOK AND FEEL
if has('nvim')
  colorscheme catppuccin-macchiato
else
  colorscheme catppuccin_macchiato
endif

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

set nomodeline                 " these aren't required

set autoindent                 " auto-indentation

set autochdir                  " auto change-dir into buffers' directories

set expandtab                  " treat tabs as spaces
set smarttab                   " treat tabs as spaces

set backspace=indent,eol,start " allows backspacing over everything in insert mode
set shiftwidth=2               " set tabs to 2 spaces
set softtabstop=2              " set tabs to 2 spaces

" Don't fix the <EOL> at the end of files
set nofixeol

" first  <Tab>  tries to complete longest match.
" second <Tab> lists possible matches
" third  <Tab> completes the next full match
set wildmode=longest,list,full
set wildmenu                   " completion with menu
set wildignore=*.o,*.obj.*.exe " ignore binaries when listing files

set wildcharm=<Tab>            " Allow <Tab> to complete in mappings

set mouse=a                    " enable mouse support

set nohidden                   " when I close a tab, remove the buffer

set nojoinspaces               " oNly one space between [.!?] and the next word

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

" C/C++ indent options to more closely match LLVM style:
" * Ls:  Jump labels indent same as everything else
" * :0:  Zero indent case labels
" * l1:  Align with case label instead of statement after it in same line
" * g0:  Zero indent C++ scope declarations
" * N-s: Zero indent inside namespaces
" * +2s: Indent continuation line more
set cinoptions=Ls:0l1g0N-s+2s

execute 'set backupdir='.g:editor_root.'/backup'

set clipboard=unnamed          " Use the '*' register
let g:clipbrdDefaultReg = '*'  " set clipboard register to '*'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Mappings                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

" Start opening the current file with no extension.
" Useful for going to header files quickly.
nnoremap <Leader>ef :e %:r.<Tab>

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
"                              ack.vim                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ackprg = 'rg --vimgrep --smart-case'

" Any empty search will search for the word under the cursor
let g:ack_use_cword_for_empty_search = 1

" Search for the word under the cursor, but wait for optional directory input
nnoremap <leader>/ :Ack! <C-R>=expand('<cword>')<CR><Space>

cnoreabbrev Ack Ack!

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              fzf.vim                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

fun! Fzfdir()
  :silent let l:git_repo = system('git rev-parse --show-toplevel')
  if v:shell_error != 0
    return getcwd()
  endif
  return trim(l:git_repo)
endfun

nnoremap <leader>o :exec ':FZF '.Fzfdir()<CR>

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
"                     Git Messenger Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:git_messenger_no_default_mappings = 1

nmap <leader>m <Plug>(git-messenger)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Custom Commands                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has('nvim')
  lua << EOF
    -- Add additional capabilities supported by nvim-cmp
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local lspconfig = require 'lspconfig'

    lspconfig.clangd.setup {
      capabilities = capabilities,
    }

    -- luasnip setup
    local luasnip = require 'luasnip'

    -- nvim-cmp setup
    local cmp = require 'cmp'
    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
        ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
        -- C-b (back) C-f (forward) for snippet placeholder navigation.
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      }),
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      },
    }

    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
    vim.keymap.set('n', '[c', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']c', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
EOF
endif

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

" Returns true if the specified window ID is a floating window. Code stolen
" from coc#window#is_float, but we don't want to rely on coc being present.
function! IsFloatingWindow(winid) abort
  if !has('nvim')
    try
      return !empty(popup_getpos(a:winid))
    catch /^Vim\%((\a\+)\)\=:E993/
      return 0
    endtry
  else
    let config = nvim_win_get_config(a:winid)
    return !empty(config) && !empty(get(config, 'relative', ''))
  endif
endfunction

" Executes a command on the current window if it's not a floating window.
function! ExecuteIfNotFloatingWindow(command)
  let currwin=winnr()
  let winid=win_getid(currwin)
  if !IsFloatingWindow(winid)
    execute a:command
  endif
endfunction

" Executes a command on all non-floating windows, restoring focus to the
" original window.
function! WinDoNFW(command)
  let currwin=winnr()
  execute 'windo call ExecuteIfNotFloatingWindow(' . string(a:command) . ')'
  execute currwin . 'wincmd w'
endfunction
com! -nargs=+ -complete=command Windo call WinDoNFW(<q-args>)ndow . "wincmd w"

" Just like WinDoNFW, but disable all autocommands for super fast processing.
command! -nargs=+ -complete=command WinDoNFWFast noautocmd call WinDoNFW(<q-args>)

" Toggle relativenumber on all non-floating windows when focus is lost/gained.
autocmd FocusLost * WinDoNFWFast set norelativenumber
autocmd FocusGained * WinDoNFWFast set relativenumber

" Automatically set the fold method to 'marker' for vim files
autocmd FileType vim setlocal foldmethod=marker
" Automatically set the fold method to 'indent' for cmake files
autocmd FileType cmake setlocal foldmethod=indent
" Teach vim about doxygen comments
autocmd FileType c,cpp setlocal comments^=:///

" Go to the last cursor location when a file is opened, unless this is a
" git commit (in which case it's annoying)
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") && &filetype != "gitcommit" |
        \ execute("normal `\"") |
    \ endif
