au BufRead,BufNewFile *.td setfiletype tablegen
au BufRead,BufNewFile *.cl setfiletype opencl
au BufRead,BufNewFile *.ll setfiletype llvm

" Source private syntax files
if filereadable(expand("~/.vim/private_filetypes.vim"))
  source ~/.vim/private_filetypes.vim
endif
