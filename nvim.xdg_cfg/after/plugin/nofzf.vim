"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF executes in the cwd, and thus is more useful when it has full access to
" the 'project scope'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if !exists(":FZF")
  set autochdir                " auto change-dir into buffers' directories
endif
