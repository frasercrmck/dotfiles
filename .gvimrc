"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              GUI Options                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

if has("gui_running")
  set guifont=Inconsolata\ for\ Powerline\ 10
endif

